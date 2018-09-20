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
