//
//  Location.swift
//  iOSTask
//
//  Created by nineleaps on 23/03/22.
//

import Foundation
import CoreLocation


class UserLocation {
    let locationManager : CLLocationManager?

    init(location :CLLocationManager ) {
        self.locationManager = location
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()

        }
    }
}






