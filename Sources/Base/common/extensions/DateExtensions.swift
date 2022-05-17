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
//  DateExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Foundation

public extension Date {

    static func fromString(_ string: String) -> Date? {
        return DateFormatter("yyyy-MM-dd'T'HH:mm:ssZZ").date(from: string)
    }

    static func monthNameForNumber(_ month: Int) -> String {
        return DateFormatter().monthSymbols[month - 1]
    }

    var debugDescription: String {
        return DateFormatter("yyyy-MM-dd HH:mm:ss a").string(from: self)
    }

    var timeString: String? {
        return DateFormatter("hh:mm a").string(from: self)
    }

    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }

    var minutes: Int {
        return Calendar.current.component(.minute, from: self)
    }

    var minutesString: String {
        var str = String(minutes)
        if minutes < 10 {
            str = "0\(str)"
        }
        return str
    }

    var utcString: String {
        return format("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }

    var monthName: String {
        return DateFormatter("MMMM").string(from: self)
    }

    var atMidnight: Date {
        let components = NSCalendar.Unit.year.union(.month).union(.day)
        let componentsWithoutTime = (Calendar.current as NSCalendar).components(components, from: self)
        return Calendar.current.date(from: componentsWithoutTime)!
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var dayOfMonth: Int {
        return (Calendar.current as NSCalendar).components(.day, from: self).day!
    }

    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    var dayOfWeek: String {
        return DateFormatter("EEEE").string(from: self)
    }

    var yearString: String {
        return DateFormatter("yyyy").string(from: self)
    }

    func format(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    func secondsSince(_ date: Date) -> TimeInterval {
        let seconds = Date().timeIntervalSince(date)
        return round(seconds * 100) / 100
    }
}
