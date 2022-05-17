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
//  KTVersionHelper.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 8/8/16.
//  Copyright © 2016 PROJECT_OWNER. All rights reserved.
//

import Foundation

public class KTVersionHelper {

    public class func buildNumber() -> String {
        return infoDictionaryValueFor("CFBundleVersion")
    }

    public class func shortVersion() -> String {
        return infoDictionaryValueFor("CFBundleShortVersionString")
    }

    public class func buildTime() -> String {
        return infoDictionaryValueFor("xBuildShortTime")
    }

    public class func gitSha() -> String {
        return infoDictionaryValueFor("xGitShortSHA")
    }

    public class func fullVersion() -> String {
        return "\(shortVersion()).\(buildNumber()) \(buildTime()) (\(gitSha()))"
    }
}
