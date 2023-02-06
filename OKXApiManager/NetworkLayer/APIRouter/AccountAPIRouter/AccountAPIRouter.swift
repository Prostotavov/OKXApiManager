//
//  AccountAPIRouter.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 6.02.23.
//

import Foundation
import Alamofire

extension APIRouter {
    enum AccountAPIRouter: APIRouterProtocol {
        // MARK: -Endpoints
        
        case balance(ccy: String)
        
        var baseURL: String {
            switch self {
            default: return "https://www.okx.cab"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .balance: return .get
            }
        }
        
        var path: String {
            switch self {
            case .balance: return "/api/v5/account/balance"
            }
        }
        
        var encoding: ParameterEncoding {
            switch method {
            default: return URLEncoding.default
            }
        }
        
        var parameters: Parameters? {
            switch self {
            case let .balance(ccy): return ["ccy": ccy]
            }
        }
        
        var body: Parameters? {
            switch self {
            case .balance: return nil
            }
        }
        
        var timeout: TimeInterval {
            switch self {
            default: return 20
            }
        }
    }
}
