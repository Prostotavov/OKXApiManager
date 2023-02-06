//
//  ConnectionSettings.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation
import Alamofire

struct ConnectionSettings { }

extension ConnectionSettings {
    static func sessionManager() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        let sessionManager = Session(configuration: configuration, startRequestsImmediately: false)
        return sessionManager
    }
}
