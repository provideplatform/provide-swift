//
//  URLExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 9/16/16.
//  Copyright © 2016 PROJECT_OWNER. All rights reserved.
//

import Foundation

public extension NSURL {

    convenience init!(_ urlString: String) {
        self.init(string: urlString)
    }
}
