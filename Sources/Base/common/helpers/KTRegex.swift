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
//  KTRegex.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Foundation

public class KTRegex {

    public class func match(_ pattern: String, input: String) -> [NSTextCheckingResult] {
        return KTRegex(pattern).match(input)
    }

    let internalExpression: NSRegularExpression!
    let pattern: String

    public init(_ pattern: String) {
        self.pattern = pattern

        do {
            internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        } catch let error as NSError {
            internalExpression = nil
            logWarn(error.localizedDescription)
        }
    }

    public func match(_ input: String) -> [NSTextCheckingResult] {
        var matches = [NSTextCheckingResult]()
        if let internalExpression = internalExpression {
            matches = internalExpression.matches(in: input, options: .anchored, range: NSRange(location: 0, length: input.distance(from: input.startIndex, to: input.endIndex)))
        }
        return matches
    }

    public func test(_ input: String) -> Bool {
        return match(input).count > 0
    }
}
