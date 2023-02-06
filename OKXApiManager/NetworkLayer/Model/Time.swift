//
//  Time.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation

// MARK: - Time
struct Time: Codable {
    let code, msg: String
    let data: [TimeDatum]
}

// MARK: - TimeDatum
struct TimeDatum: Codable {
    let ts: String
}
