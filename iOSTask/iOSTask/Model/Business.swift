//
//  Business.swift
//  iOSTask
//
//  Created by nineleaps on 22/03/22.
//

import Foundation

import Foundation

struct Business: Codable, Identifiable {
    var id: String?
    var name: String?
    var price: String?
    var distance: Double?
    var image_url: String?
    var categories: [Categories]?
    var coordinates: Coordinates?
    var location : Location?
    var url: String?
    var phone: String?
    var review_count : Int?
}

struct Categories: Codable {
    var alias: String?
    var title: String?
}

struct Coordinates: Codable {
    var latitude: Double?
    var longitude: Double?
}

struct Location: Codable {
    var city : String?
    var country : String?
}
