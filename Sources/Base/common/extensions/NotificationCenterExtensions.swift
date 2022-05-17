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
//  NotificationCenterExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Foundation

// This is a dummy class just to namespace the convenience methods
public class KTNotificationCenter {
    public class func post(name: Notification.Name, object: Any? = nil) {
        NotificationCenter.default.post(name: name, object: object)
    }

    public class func addObserver(forName name: NSNotification.Name?, object: Any? = nil, queue: OperationQueue? = nil, using block: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: name, object: object, queue: queue, using: block)
    }

    public class func addObserver(observer: Any, selector: Selector, name: NSNotification.Name?, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}
