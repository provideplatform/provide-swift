//
//  BuildConfig.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/30/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Foundation

#if DEBUG
let CurrentBuildConfig = BuildConfig.debug
#elseif APP_STORE
let CurrentBuildConfig = BuildConfig.appStore
#elseif true
let CurrentBuildConfig = BuildConfig.debug
#endif

public enum BuildConfig {
    case debug, appStore
}
