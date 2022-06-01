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
//  CLLocationExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import CoreLocation

let timeIntervalSinceThreshold: Double = 1.0
let horizontalAccuracyThreshold: Double = 10.0
let verticalAccuracyThreshold: Double = 10.0
let earthRadiusInMiles = 3964.037911746

public extension CLLocation {

    var isAccurate: Bool {
        return realTime && horizontallyAccurate && verticallyAccurate && validSpeed
    }

    var isAccurateForForcedLocationUpdate: Bool {
        return realTime && (horizontallyAccurate || verticallyAccurate)
    }

    var realTime: Bool {
        return abs(timestamp.timeIntervalSinceNow) < timeIntervalSinceThreshold
    }

    var horizontallyAccurate: Bool {
        return horizontalAccuracy >= 0.0 && horizontalAccuracy <= horizontalAccuracyThreshold
    }

    var verticallyAccurate: Bool {
        return (verticalAccuracy >= 0.0 && verticalAccuracy <= verticalAccuracyThreshold) || isSimulator()
    }

    var validSpeed: Bool {
        return speed >= 0.0 || isSimulator()
    }
}
