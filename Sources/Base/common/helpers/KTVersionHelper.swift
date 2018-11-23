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
