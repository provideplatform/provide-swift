//
//  KTError.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 7/9/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import ObjectMapper

public class KTError: KTModel {

    public var message: String!
    public var status: Int!

    public override func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
    }
}
