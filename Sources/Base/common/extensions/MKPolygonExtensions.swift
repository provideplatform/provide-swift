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
//  MKPolygonExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import MapKit

public extension MKPolygon {

    class func areaWithPoints(_ points: [CGPoint]) -> CGFloat {
        if points.count < 3 {
            return 0.0
        }

        var result: CGFloat = 0.0

        var previousPoint = points[points.count - 1]

        for point in points {
            result += (previousPoint.x * point.y) - (previousPoint.y * point.x)
            previousPoint = point
        }

        return result / 2.0
    }

    var area: CGFloat {
        var points = [CGPoint]()

        for i in 0..<pointCount {
            let point = self.points()[i]
            points.append(CGPoint(x: point.x, y: point.y))
        }

        var result = MKPolygon.areaWithPoints(points)

        for interior in interiorPolygons ?? [] {
            result -= interior.area
        }

        return result
    }
}
