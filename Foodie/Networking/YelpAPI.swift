//
//  YelpAPI.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-15.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import Foundation
import Moya
import Result

typealias MoyaResult = Result<Moya.Response, MoyaError>
let baseYelpUrlString = "https://api.yelp.com"

public enum YelpTarget {
    case search([String]?, String?, String, Int)
    case reviews(String)
}

extension YelpTarget: TargetType {
    public var baseURL: URL { return URL(string: baseYelpUrlString)! }
    
    public var path: String {
        switch self {
        case .search(_,_, _, _):
            return "/v3/businesses/search"
        case let .reviews(id):
            return "/v3/businesses/\(id.urlEscaped)/reviews"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .search:
            return .get
        case .reviews(_):
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .search(categoriesArr?, term?, location, limit):
            let categories = categoriesArr.joined(separator: ",")
            return ["categories": categories.urlEscaped, "term": term.urlEscaped, "location": location.urlEscaped, "limit": limit]
        case let .search(_, term?, location, limit):
            return ["term": term.urlEscaped, "location": location.urlEscaped, "limit": limit]
        case let .search(categoriesArr?, _, location, limit):
            let categories = categoriesArr.joined(separator: ",")
            return ["categories": categories.urlEscaped, "location": location.urlEscaped, "limit": limit]
        case let .search(_, _, location, limit):
            return ["location": location.urlEscaped, "limit": limit]
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
    
    public var validate: Bool {
        return true
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return "dummy".data(using: String.Encoding.utf8)!
        }
    }
}

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
