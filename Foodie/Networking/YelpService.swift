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
import SwiftyJSON

typealias ResponseConverter = (MoyaResult, (JSON?, MoyaError?) -> Void) -> ()
typealias Parser<T: Model> = (JSON) -> T?

class YelpService {
    
    static let shared = YelpService()
    
    let provider: MoyaProvider<YelpTarget>
    let responseConverter: ResponseConverter
    
    private init() {
        let oauthHandler = YelpOAuth2Handler(clientId: "zZhBiivvN4Iq-hyzS9XvMQ",
                                         clientSecret: "ZYNEbuiVWGZxoSZctAHp2ngqVAQYajGqZ1Z4oPNEKlQY8sxC19IAqIOJJDJU4xOI",
                                         baseURLString: baseYelpUrlString)
        let sessionManager = SessionManager()
        sessionManager.adapter = oauthHandler
        sessionManager.retrier = oauthHandler
        provider = MoyaProvider<YelpTarget>(manager: sessionManager)
        responseConverter = {(result, completion: (JSON?, MoyaError?) -> ()) in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let response):
                switch response.statusCode {
                case 200..<300:
                    let data = response.data
                    let json = JSON(data: data)
                    
                    completion(json, nil)
                default:
                    completion(nil, .statusCode(response))
                }
            }
        }
    }
    
    func searchBusinesses(term: String?, location: String, completion: @escaping ([Business]?, MoyaError?) -> Void) {
        self.provider.request(.search(term, location, 10)) { (result) in
            self.responseConverter(result, { (json, error) in
                guard let businesses = json?["businesses"].array,
                error == nil else {
                    completion(nil, error)
                    return
                }
                
                let parser: Parser<Business> = { json in
                    return Business.fromJSON(json)
                }
                
                completion(businesses.flatMap(parser), nil)
            })
        }
    }
    
    func getReviews(businessId: String, completion: @escaping ([Review]?, MoyaError?) -> Void) {
        self.provider.request(.reviews(businessId)) { (result) in
            self.responseConverter(result, { (json, error) in
                guard let reviews = json?["reviews"].array,
                    error == nil else {
                        completion(nil, error)
                        return
                }
                
                let parser: Parser<Review> = { json in
                    return Review.fromJSON(json)
                }
                
                completion(reviews.flatMap(parser), nil)
            })
        }
    }
}
