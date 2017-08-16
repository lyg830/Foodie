//
//  OAuth2Handler.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-15.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess

class YelpOAuth2Handler {
    fileprivate typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?) -> Void
    
    fileprivate let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: configuration)
    }()
    
    fileprivate let lock = NSLock()
    
    fileprivate var clientId: String
    fileprivate var clientSecret: String
    fileprivate var baseURLString: String
    fileprivate var accessToken: String?
    
    fileprivate var isRefreshing = false
    fileprivate var requestsToRetry: [RequestRetryCompletion] = []
    
    // MARK: - Initialization
    
    public init(clientId: String, clientSecret: String, baseURLString: String) {
        let keychain = Keychain(server: baseURLString, protocolType: .https)
        
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.baseURLString = baseURLString
        self.accessToken = keychain["access_token"]
    }
    
    fileprivate func storeAccessToken(_ accessToken: String) {
        let keychain = Keychain(server: baseURLString, protocolType: .https)
        keychain["access_token"] = accessToken
    }
}

extension YelpOAuth2Handler: RequestRetrier {
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    
                    if let accessToken = accessToken {
                        strongSelf.accessToken = accessToken
                        strongSelf.storeAccessToken(accessToken)
                    }
                    
                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        } else {
            completion(false, 0.0)
        }
    }
    
    // MARK: - Private - Refresh Tokens
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        
        isRefreshing = true
        
        let urlString = "\(baseURLString)/oauth2/token"
        
        let parameters: [String: Any] = [
            "grant_type": "client_credentials",
            "client_secret": clientSecret,
            "client_id": clientId
        ]
        
        sessionManager.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { [weak self] response in
                guard let strongSelf = self else { return }
                
                if let json = response.result.value as? [String: Any],
                    let accessToken = json["access_token"] as? String {
                    completion(true, accessToken)
                } else {
                    completion(false, nil)
                }
                
                strongSelf.isRefreshing = false
        }
    }
}

extension YelpOAuth2Handler: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if let urlString = urlRequest.url?.absoluteString,
            let accessToken = self.accessToken,
            urlString.hasPrefix(baseURLString) {
            var urlRequest = urlRequest
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            return urlRequest
        }
        
        return urlRequest
    }

}
