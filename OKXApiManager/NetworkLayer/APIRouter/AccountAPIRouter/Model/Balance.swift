//
//  Balance.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation

// MARK: - Balance
struct Balance: Codable {
    let code: String
    let data: [BalanceDatum]
    let msg: String
}

// MARK: - BalanceDatum
struct BalanceDatum: Codable {
    let adjEq: String
    let details: [BalanceDetail]
    let imr, isoEq, mgnRatio, mmr: String
    let notionalUsd, ordFroz, totalEq, uTime: String
}

// MARK: - BalanceDetail
struct BalanceDetail: Codable {
    let availBAL, availEq, cashBAL, ccy: String
    let crossLiab, disEq, eq, eqUsd: String
    let fixedBAL, frozenBAL, interest, isoEq: String
    let isoLiab, isoUpl, liab, maxLoan: String
    let mgnRatio, notionalLever, ordFrozen, twap: String
    let uTime, upl, uplLiab, stgyEq: String
    let spotInUseAmt: String

    enum CodingKeys: String, CodingKey {
        case availBAL = "availBal"
        case availEq
        case cashBAL = "cashBal"
        case ccy, crossLiab, disEq, eq, eqUsd
        case fixedBAL = "fixedBal"
        case frozenBAL = "frozenBal"
        case interest, isoEq, isoLiab, isoUpl, liab, maxLoan, mgnRatio, notionalLever, ordFrozen, twap, uTime, upl, uplLiab, stgyEq, spotInUseAmt
    }
}
