//
//  APIService.swift
//  iOSTask
//
//  Created by nineleaps on 22/03/22.
//

import Foundation


struct SearchResults: Codable {
    let total: Int
    let businesses: [Business]
}

public class APIService {
    
    static let shared = APIService()
    
    
    
    func fetchBusinesses(latitude: Double,
                         longitude: Double,
                         radius: Double,
                         sortBy: String,
                         categories: String,
                         term:String,
                         completion: @escaping ([Business]) -> Void) {
        
        
        let strWithNoSpace = term.replacingOccurrences(of: " ", with: "%20")
        
       
        let baseURL = Yelp.baseURL+"?latitude=\(latitude)&longitude=\(longitude)&categories=\(categories)&sort_by=\(sortBy)&term=\(strWithNoSpace)&limit=\(50)"
        

        let url = URL(string: baseURL)
        var urlRequest = URLRequest(url: url!)
        urlRequest.setValue("Bearer \(Yelp.apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                let searchResult = try? JSONDecoder().decode(SearchResults.self, from: data)
                if let searchResult = searchResult {
                    completion(searchResult.businesses)
                } else {
                }

            } else {
                completion([])
                print(error?.localizedDescription as Any)
            }
        }.resume()
    }
}





