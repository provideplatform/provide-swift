//
//  DataExtensions.swift
//  Provide
//
//  Created by Kyle Thomas on 11/22/18.
//

import Foundation

extension Data {

    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }

    func sha256() -> Data {
        let bytes: Array<UInt8> = Array(self)
        let result = SHA256(bytes).calculate32()
        return Data(bytes: result)
    }
}
