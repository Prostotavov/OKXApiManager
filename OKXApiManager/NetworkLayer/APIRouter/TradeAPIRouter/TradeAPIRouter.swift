//
//  TradeAPIRouter.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 6.02.23.
//

import Foundation
import Alamofire

extension APIRouter {
    enum TradeAPIRouter: APIRouterProtocol {
        // MARK: -Endpoints
        
        case order(postOrder: PostOrder)
        
        var baseURL: String {
            switch self {
            default: return "https://www.okx.cab"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .order: return .post
            }
        }
        
        var path: String {
            switch self {
            case .order: return "/api/v5/trade/order"
            }
        }
        
        var encoding: ParameterEncoding {
            switch method {
            default: return URLEncoding.default
            }
        }
        
        var parameters: Parameters? {
            switch self {
            case .order: return nil
            }
        }
        
        var body: Parameters? {
            switch self {
            case let .order(postOrder): return postOrder.bodyForAPIRequest()
            }
        }
        
        var timeout: TimeInterval {
            switch self {
            default: return 20
            }
        }
    }
}
