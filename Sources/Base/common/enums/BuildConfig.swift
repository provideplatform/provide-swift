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
