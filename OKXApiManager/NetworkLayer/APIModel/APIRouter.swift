//
//  APIRouter.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation
import Alamofire

struct APIRouterStruct: URLRequestConvertible {
    
    let apiRouter: APIRouter
    let apiKeys: APIKeys
    
    private func timestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: Date())
    }
    
    private func stringParameters(parameters: Parameters?) -> String {
        guard let parameters else { return "" }
        var stringParameters = "?"
        for (key, value) in parameters {
            let stringValue = value as? String ?? ""
            stringParameters += key + "=" + stringValue + "&"
        }
        return String(stringParameters.dropLast())
    }
    
    func asURLRequest() throws -> URLRequest {
        let stringParameters = stringParameters(parameters: apiRouter.parameters)
        let url = try (apiRouter.baseURL + apiRouter.path + stringParameters).asURL()
        var urlRequest = URLRequest(url: url)
        
        if let body = apiRouter.body {
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: body)
                urlRequest.httpBody = httpBody
                
            } catch {
                print("Fail to generate JSON data")
            }
        }
        
        let timestamp = timestamp()
        let sign = APISing(method: apiRouter.method, path: apiRouter.path,
                           stringParameters: stringParameters, httpBody: urlRequest.httpBody,
                           secretKey: apiKeys.secretKey, timestamp: timestamp)
        let headers = APIHeaders(key: apiKeys.key, passphrase: apiKeys.passphrase,
                                 sign: sign, timestamp: timestamp)
        
        urlRequest.httpMethod = apiRouter.method.rawValue
        urlRequest.timeoutInterval = apiRouter.timeout
        urlRequest.headers = headers.getHeaders()
        
        print("urlRequest: \(urlRequest)")
        return urlRequest
    }
}

enum APIRouter {
    
    // MARK: -Endpoints
    
    case time
    case balance(ccy: String)
    case order(postOrder: PostOrder)
    
    var baseURL: String {
        switch self {
        default: return "https://www.okx.cab"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .time: return .get
        case .balance: return .get
        case .order: return .post
        }
    }
    
    var path: String {
        switch self {
        case .time: return "api/v5/public/time"
        case .balance: return "/api/v5/account/balance"
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
        case .time: return nil
        case let .balance(ccy): return ["ccy": ccy]
        case .order: return nil
        }
    }
    
    var body: Parameters? {
        switch self {
        case .time: return nil
        case .balance: return nil
        case let .order(postOrder): return postOrder.bodyForAPIRequest()
        }
    }
    
    var timeout: TimeInterval {
        switch self {
        default: return 20
        }
    }
}
