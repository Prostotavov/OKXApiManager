//
//  PublicAPIRouter.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 6.02.23.
//

import Foundation
import Alamofire

enum PublicAPIRouter: APIRouterProtocol {
    // MARK: -Endpoints
    
    case time
    
    var baseURL: String {
        switch self {
        default: return "https://www.okx.cab"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .time: return .get
        }
    }
    
    var path: String {
        switch self {
        case .time: return "api/v5/public/time"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        default: return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .time: return nil
        }
    }
    
    var body: Parameters? {
        switch self {
        case .time: return nil
        }
    }
    
    var timeout: TimeInterval {
        switch self {
        default: return 20
        }
    }
}
