//
//  SessionHelpers.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation
import Alamofire
import PromiseKit

enum InternalError: LocalizedError {
    case unexpected
}

extension Session {
    
    func request<T: Codable>(_ urlRequestConvertible: APIRouterStruct) -> Promise<T> {
        return Promise<T> { seal in
            request(urlRequestConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                guard response.response != nil else {
                    if let error = response.error {
                        seal.reject(error)
                    } else {
                        seal.reject(InternalError.unexpected)
                    }
                    return
                }
                
                switch response.result {
                case let .success(value):
                    seal.fulfill(value)
                case let .failure(error):
                    seal.reject(error)
                }
            }
            .resume()
        }
    }
    
}
