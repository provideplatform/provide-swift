//
//  KTPresignedS3Request.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 7/4/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import ObjectMapper

public class KTPresignedS3Request: KTModel {

    public var fields: [String: String]!
    public var metadata = [String: String]()
    public var signedHeaders = [String: String]()
    public var url: String!

    public override func mapping(map: Map) {
        metadata <- map["metadata"]
        fields <- map["fields"]
        signedHeaders <- map["signed_headers"]
        url <- map["url"]
    }
}
