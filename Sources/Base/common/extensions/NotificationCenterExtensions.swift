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
