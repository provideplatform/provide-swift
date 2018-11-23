//
//  DateFormatterExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Foundation

public extension DateFormatter {

    convenience init(_ dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }

    convenience init(dateStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
    }

    class func localizedStringFromDate(_ date: Date, dateStyle: DateFormatter.Style) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: dateStyle, timeStyle: .none)
    }
}
