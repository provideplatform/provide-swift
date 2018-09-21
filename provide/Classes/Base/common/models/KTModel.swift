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
