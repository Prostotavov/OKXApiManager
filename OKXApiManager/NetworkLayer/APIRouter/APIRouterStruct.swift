//
//  APIRouterStruct.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 6.02.23.
//

import Foundation
import Alamofire

struct APIRouterStruct: URLRequestConvertible {
    
    let apiRouter: APIRouter
    let apiKeys: APIKeys
    
    init(_ apiRouter: APIRouter, _ apiKeys: APIKeys) {
        self.apiRouter = apiRouter
        self.apiKeys = apiKeys
    }
    
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
        let sign = APISign(method: apiRouter.method, path: apiRouter.path,
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
