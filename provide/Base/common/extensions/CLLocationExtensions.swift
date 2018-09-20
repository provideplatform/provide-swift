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
