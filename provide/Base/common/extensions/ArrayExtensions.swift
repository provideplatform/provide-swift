//
//  ArrayExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Foundation

public extension Array {
    func toJSONString() -> String {
        let jsonData = encodeJSON(self)
        return String(data: jsonData, encoding: .utf8)!
    }

    mutating func removeObject<U: Equatable>(_ object: U) {
        for (index, objectToCompare) in enumerated() {
            if let to = objectToCompare as? U, object == to {
                remove(at: index)
                break
            }
        }
    }
}
