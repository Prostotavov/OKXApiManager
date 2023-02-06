//
//  APIRouter.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation
import Alamofire

protocol APIRouterProtocol {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters? { get }
    var body: Parameters? { get }
    var timeout: TimeInterval { get }
}

enum APIRouter: APIRouterProtocol {
    
    case trade(_: TradeAPIRouter)
    case account(_: AccountAPIRouter)
    case `public`(_: PublicAPIRouter)
    
    var baseURL: String {
        switch self {
        case let .trade(value):
            return value.baseURL
        case let .account(value):
            return value.baseURL
        case let .public(value):
            return value.baseURL
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case let .trade(value):
            return value.method
        case let .account(value):
            return value.method
        case let .public(value):
            return value.method
        }
    }
    
    var path: String {
        switch self {
        case let .trade(value):
            return value.path
        case let .account(value):
            return value.path
        case let .public(value):
            return value.path
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case let .trade(value):
            return value.encoding
        case let .account(value):
            return value.encoding
        case let .public(value):
            return value.encoding
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .trade(value):
            return value.parameters
        case let .account(value):
            return value.parameters
        case let .public(value):
            return value.parameters
        }
    }
    
    var body: Parameters? {
        switch self {
        case let .trade(value):
            return value.body
        case let .account(value):
            return value.body
        case let .public(value):
            return value.body
        }
    }
    
    var timeout: TimeInterval {
        switch self {
        case let .trade(value):
            return value.timeout
        case let .account(value):
            return value.timeout
        case let .public(value):
            return value.timeout
        }
    }
}
