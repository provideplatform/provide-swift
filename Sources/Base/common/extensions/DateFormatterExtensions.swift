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
