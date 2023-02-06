//
//  String + HMAC.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import Foundation
import CommonCrypto
import CryptoKit

extension String {
    
    func hmac(key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), key, key.count, self, self.count, &digest)
        let data = Data(digest)
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
}
