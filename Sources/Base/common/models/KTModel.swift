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
//  KTModel.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 7/9/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import ObjectMapper

public class KTModel: NSObject, Mappable {

    var ivars: [String] {
        var count: UInt32 = 0
        let ivars: UnsafeMutablePointer<OpaquePointer> = class_copyIvarList(type(of: self), &count)!

        var ivarStrings = [String]()
        for i in 0..<count {
            let key = (NSString(cString: ivar_getName(ivars[Int(i)])!, encoding: String.Encoding.utf8.rawValue)! as String) as String
            ivarStrings.append(key)
        }
        ivars.deallocate(capacity: Int(count))
        return ivarStrings
    }

    public override var description: String {
        return "\(toJSONString(prettyPrint: true)!)"
    }

    public override required init() {
        super.init()
    }

    public required init?(map: Map) {
        super.init()
    }

    public func mapping(map: Map) {
        // no-op by default
    }
}
