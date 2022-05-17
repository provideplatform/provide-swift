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
