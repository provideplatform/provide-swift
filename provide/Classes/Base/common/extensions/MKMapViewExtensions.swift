//
//  MKMapViewExtensions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import MapKit

let mercatorOffset = Double(268435456)
let mercatorRadius = Double(85445659.44705395)

public extension MKMapView {

    // MARK: Map conversion methods

    func degToRad(_ deg: Double) -> Double {
        return deg * .pi / 180.0
    }

    func longitudeToPixelSpaceX(_ longitude: Double) -> Double {
        return round(mercatorOffset + mercatorRadius * longitude * .pi / 180.0)
    }

    func latitudeToPixelSpaceY(_ latitude: Double) -> Double {
        let radLat = degToRad(latitude)
        let sinRadLat = sin(radLat)
        return round(mercatorOffset - mercatorRadius * log((1 + sinRadLat) / (1 - sinRadLat)) / 2.0)
    }

    func pixelSpaceXToLongitude(_ x: Double) -> Double {
        return ((round(x) - mercatorOffset) / mercatorRadius) * 180.0 / .pi
    }

    func pixelSpaceYToLatitude(_ y: Double) -> Double {
        return (.pi / 2.0 - 2.0 * atan(exp((round(y) - mercatorOffset) / mercatorRadius))) * 180.0 / .pi
    }

    // MARK: Helper methods

    func coordinateSpan(_ centerCoordinate: CLLocationCoordinate2D, zoomLevel: Double) -> MKCoordinateSpan {
        let centerX = longitudeToPixelSpaceX(centerCoordinate.longitude)
        let centerY = latitudeToPixelSpaceY(centerCoordinate.latitude)

        let zoomExponent = 20 - zoomLevel
        let zoomScale = pow(2, zoomExponent)

        let mapSize = bounds.size
        let scaledMapWidth = Double(mapSize.width) * zoomScale
        let scaledMapHeight = Double(mapSize.height) * zoomScale

        let topLeftX = centerX - (scaledMapWidth / 2)
        let topLeftY = centerY - (scaledMapHeight / 2)

        let minLng = pixelSpaceXToLongitude(topLeftX)
        let maxLng = pixelSpaceXToLongitude(topLeftX + scaledMapWidth)
        let longitudeDelta = maxLng - minLng

        let minLat = pixelSpaceYToLatitude(topLeftY)
        let maxLat = pixelSpaceYToLatitude(topLeftY + scaledMapHeight)
        let latitudeDelta = -1 * (maxLat - minLat)

        return MKCoordinateSpan.init(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }

    // MARK: Set center coordinate and zoom

    func setCenterCoordinate(_ centerCoordinate: CLLocationCoordinate2D, zoomLevel: UInt, animated: Bool) {
        let zoomLevel = min(zoomLevel, 28)

        let span = coordinateSpan(centerCoordinate, zoomLevel: Double(zoomLevel))
        let region = MKCoordinateRegion.init(center: centerCoordinate, span: span)

        setRegion(region, animated: animated)
    }

    func setCenterCoordinate(_ centerCoordinate: CLLocationCoordinate2D, fromEyeCoordinate: CLLocationCoordinate2D, eyeAltitude: CLLocationDistance = 0, pitch: CGFloat = 0, heading: CLLocationDirection = 0, animated: Bool = true) {
        let invalidCenterCoordinate = centerCoordinate.latitude == -180.0 && centerCoordinate.longitude == -180.0
        if invalidCenterCoordinate {
            return
        }

        let camera = MKMapCamera(
            lookingAtCenter: centerCoordinate,
            fromEyeCoordinate: fromEyeCoordinate,
            eyeAltitude: eyeAltitude)

        if heading >= 0.0 {
            camera.heading = heading
        }

        camera.pitch = pitch

        setCamera(camera, animated: animated)
    }

    // MARK: Set heading

    func setHeading(_ heading: CLHeading) {
        camera.heading = heading.trueHeading
    }

    // MARK: User interaction

    func setUserInteraction(enabled: Bool) {
        isScrollEnabled = enabled
        isZoomEnabled = enabled
    }

    func disableUserInteraction() {
        setUserInteraction(enabled: false)
    }

    func enableUserInteraction() {
        setUserInteraction(enabled: true)
    }
}
