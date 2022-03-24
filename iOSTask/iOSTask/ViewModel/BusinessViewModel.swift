//
//  BusinessViewModel.swift
//  iOSTask
//
//  Created by nineleaps on 23/03/22.
//

import Foundation
import CoreLocation

class BusinessViewModel {
    
    var busniess : [Business]?
    var userLocation = UserLocation(location: CLLocationManager())
    var searchTerm = ""
    
    
    
    func fetchBusinesses(latitiude: Double, longitude: Double,completion: @escaping ([Business]) -> Void) {
        APIService.shared.fetchBusinesses(latitude: latitiude, longitude: longitude, radius: 40000, sortBy: "distance", categories: FilterViewModel.selectedCategory,term: searchTerm) { (businesses) in
                self.busniess = businesses
                completion(self.busniess ?? [])
        }
    }
    
    
    
    
    
}
