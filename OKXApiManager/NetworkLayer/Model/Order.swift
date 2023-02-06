//
//  Order.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation

// MARK: - Order
struct Order: Codable {
    let code, msg: String
    let data: [OrderDatum]
}

// MARK: - OrderDatum
struct OrderDatum: Codable {
    let clOrdID, ordID, tag, sCode: String
    let sMsg: String

    enum CodingKeys: String, CodingKey {
        case clOrdID = "clOrdId"
        case ordID = "ordId"
        case tag, sCode, sMsg
    }
}

// MARK: - PostOrder
struct PostOrder {
    let instID: String
    let tdMode: String
    let side: String
    let ordType: String
    let px: String
    let sz: String
}

extension PostOrder {
    func bodyForAPIRequest() -> [String: Any] {
        var body: [String: Any] = [:]
        body["instId"] = instID
        body["tdMode"] = tdMode
        body["side"] = side
        body["ordType"] = ordType
        body["px"] = px
        body["sz"] = sz
        return body
    }
}
