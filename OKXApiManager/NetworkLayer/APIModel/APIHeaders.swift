//
//  APIHeaders.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Alamofire

struct APIHeaders {
    var contentType: String = "application/json"
    var key: String
    var passphrase: String
    var sign: APISing
    var timestamp: String
    var isSimulated: String = "0"
    
    func getHeaders() -> HTTPHeaders {
        var headersDictionary: [String: String] = [:]
        headersDictionary["Content-Type"] = contentType
        headersDictionary["OK-ACCESS-KEY"] = key
        headersDictionary["OK-ACCESS-SIGN"] = sign.getSign()
        headersDictionary["OK-ACCESS-TIMESTAMP"] = timestamp
        headersDictionary["OK-ACCESS-PASSPHRASE"] = passphrase
        headersDictionary["x-simulated-trading"] = isSimulated
        return HTTPHeaders(headersDictionary)
    }
}
