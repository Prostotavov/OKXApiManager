//
//  APISign.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation
import Alamofire

struct APISign {
    var method: HTTPMethod
    var path: String
    var stringParameters: String = ""
    var httpBody: Data?
    var secretKey: String
    var timestamp: String
    
    func encodedSign() -> String {
        let singURL = timestamp + method.rawValue + path + stringParameters + stringBody()
        print("\(singURL)")
        return singURL.hmac(key: secretKey)
    }
    
    private func stringBody() -> String {
        guard let httpBody else { return "" }
        let stringBody = String(data: httpBody, encoding: String.Encoding.utf8) ?? ""
        return stringBody
    }
}
