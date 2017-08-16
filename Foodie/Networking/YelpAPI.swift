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
    case search(String, Int)
}

extension YelpTarget: TargetType {
    public var baseURL: URL { return URL(string: baseYelpUrlString)! }
    
    public var path: String {
        switch self {
        case let .search(location, limit):
            return "/v3/businesses/search?location=\(location.urlEscaped)&limit=\(limit)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
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
            return "{\"copyright\": \"C\\u00e9sar Blanco\\nGonz\\u00e1lez\",\"date\": \"2017-07-20\",\"explanation\": \"Stunning emission nebula IC 1396 mixes glowing cosmic gas and dark dust clouds in the high and far off constellation of Cepheus. Energized by the bright central star seen here, this star forming region sprawls across hundreds of light-years, spanning over three degrees on the sky while nearly 3,000 light-years from planet Earth. Among the intriguing dark shapes within IC 1396, the winding Elephant's Trunk nebula lies just below center. Stars could still be forming inside the dark shapes by gravitational collapse. But as the denser clouds are eroded away by powerful stellar winds and radiation, any forming stars will ultimately be cutoff from the reservoir of star stuff.  The gorgeous color view is a composition of image data from narrowband filters, mapping emission from the nebula's atomic oxygen, hydrogen, and sulfur into blue, green, and red hues.\",\"hdurl\": \"https://apod.nasa.gov/apod/image/1707/MOSAIC_IC1396_HaSHO_blanco.jpg\\\",\"media_type\": \"image\",\"service_version\": \"v1\",\"title\": \"IC 1396: Emission Nebula in Cepheus\",\"url\": \"https://apod.nasa.gov/apod/image/1707/MOSAIC_IC1396_HaSHO_blanco1024.jpg\"}".data(using: String.Encoding.utf8)!
        }
    }
}

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
