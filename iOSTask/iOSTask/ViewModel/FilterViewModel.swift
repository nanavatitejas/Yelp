//
//  FilterViewModel.swift
//  iOSTask
//
//  Created by nineleaps on 24/03/22.
//

import Foundation
import CoreLocation

struct FilterViewModel {
    
    let searchCategories = ["burgers","pizza","mexican","chinese"]
    var locations = [String:CLLocationCoordinate2D]()
    
    static var selectedLocation = CLLocationCoordinate2D()
    static var selectedCategory = ""
    
    
    init() {
        self.addLocations()
    }
    
    private mutating func addLocations() {
        
        let londonLatLong = CLLocationCoordinate2D(latitude: 51.50998, longitude: -0.1337)
        locations["London"] = londonLatLong
        
        
        let newyorkLatLong = CLLocationCoordinate2D(latitude: 40.759211, longitude: -73.984638)
        locations["New York"] = newyorkLatLong
        
        let beijingLatLong = CLLocationCoordinate2D(latitude: 19.4354778, longitude: -99.1364789)
        locations["Mexico City"] = beijingLatLong
        
        let sydneyLatLong = CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)
        locations["Sydney"] = sydneyLatLong
        
    }
}
