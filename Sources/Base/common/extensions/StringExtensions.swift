// Copyright 2017-2022 Provide Technologies Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  StringExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Foundation

infix operator =~ : AssignmentPrecedence
public func =~ (input: String, pattern: String) -> Bool {
    return KTRegex(pattern).test(input)
}

public extension String {

    var length: Int {
        return lengthOfBytes(using: .utf8)
    }

    var base64EncodedString: String {
        return Data(bytes: [UInt8] (utf8)).base64EncodedString(options: [])
    }

    func urlEncodedString() -> String {
        return replacingOccurrences(of: " ", with: "+").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }

    private func toJSONAny() -> Any? {
        do {
            let data = self.data(using: .utf8)
            let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            return jsonObject
        } catch let error as NSError {
            logWarn(error.localizedDescription)
            return nil
        }
    }

    func toJSONArray() -> [Any]? {
        return toJSONAny() as? [Any]
    }

    func toJSONObject() -> [String: Any]? {
        return toJSONAny() as? [String: Any]
    }

    func snakeCaseToCamelCaseString() -> String {
        let items: [String] = components(separatedBy: "_")
        var camelCase = ""
        var isFirst = true
        for item: String in items {
            if isFirst {
                isFirst = false
                camelCase += item
            } else {
                camelCase += item.capitalized
            }
        }
        return camelCase
    }

    func snakeCaseString() -> String {
        guard let pattern = try? NSRegularExpression(pattern: "([a-z])([A-Z])", options: []) else { fatalError() }
        return pattern.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: count), withTemplate: "$1_$2").lowercased()
    }

    var containsNonASCIICharacters: Bool {
        return !canBeConverted(to: String.Encoding.ascii)
    }

    // MARK: Validation Methods

    func containsRegex(_ searchString: String) -> Bool {
        return range(of: searchString, options: .regularExpression) != nil
    }

    func containsOneOrMoreNumbers() -> Bool {
        return rangeOfCharacter(from: .decimalDigits) != nil
    }

    func containsOneOrMoreUppercaseLetters() -> Bool {
        return rangeOfCharacter(from: .uppercaseLetters) != nil
    }

    func containsOneOrMoreLowercaseLetters() -> Bool {
        return rangeOfCharacter(from: .lowercaseLetters) != nil
    }

    func isDigit() -> Bool {
        guard let int = Int(self) else { return false }
        return (length == 1) && (int >= 0) && (int <= 9)
    }

    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }

    func stringByStrippingHTML() -> String {
        var range = NSRange(location: 0, length: 0)
        var str = NSString(string: self)
        while range.location != NSNotFound {
            range = str.range(of: "<[^>]+>", options: .regularExpression)
            if range.location != NSNotFound {
                str = str.replacingCharacters(in: range, with: "") as NSString
            }
        }
        return str as String
    }
}
