//
//  YelpService.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-15.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import Foundation
import Moya
import Result
import Alamofire

struct ModelMapper {
    static func map<T: Model>(_ result: MoyaResult, callback: @escaping (T?, MoyaError?) -> Void) -> Void {
        switch result {
        case .failure(let error):
            callback(nil, error)
        case .success(let response):
            switch response.statusCode {
            case 200..<300:
                guard let json = try? response.mapJSON() else {
                    callback(nil, .jsonMapping(response))
                    return
                }
                
                guard let t = T.fromJSON(json) else {
                    callback(nil, .jsonMapping(response))
                    return
                }
                
                callback(t, nil)
            default:
                callback(nil, .statusCode(response))
            }
        }
    }
}

class YelpService {
    
    static let shared = YelpService()
    
    let provider: MoyaProvider<YelpTarget>
    
    private init() {
        let oauthHandler = YelpOAuth2Handler(clientId: "zZhBiivvN4Iq-hyzS9XvMQ",
                                         clientSecret: "ZYNEbuiVWGZxoSZctAHp2ngqVAQYajGqZ1Z4oPNEKlQY8sxC19IAqIOJJDJU4xOI",
                                         baseURLString: baseYelpUrlString)
        let sessionManager = SessionManager()
        sessionManager.adapter = oauthHandler
        sessionManager.retrier = oauthHandler
        provider = MoyaProvider<YelpTarget>(manager: sessionManager)

    }
    
//    func getApod(completion: @escaping (Picture?, MoyaError?) -> Void) {
//        provider.request(.apod) { (result) in
//            ModelMapper<Picture>.map(result, callback: completion)
//        }
//    }
    
    
}
