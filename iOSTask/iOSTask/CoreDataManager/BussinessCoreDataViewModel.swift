//
//  BussinessCoreDataViewModel.swift
//  iOSTask
//
//  Created by nineleaps on 24/03/22.
//

import Foundation
import CoreData

class BussinessCoreDataViewModel {
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    func saveLocally(detailVM:DetailViewModel ) {
        
        checkDataForDelete()
        let savedRestaurant = NSEntityDescription.insertNewObject(forEntityName: "BusinessCD", into: context)
        savedRestaurant.setValue(detailVM.business?.id, forKey: "id")
        savedRestaurant.setValue(detailVM.business?.name, forKey: "name")
        savedRestaurant.setValue(detailVM.business?.price, forKey: "price")
        savedRestaurant.setValue(detailVM.business?.image_url, forKey: "imageUrl")
        savedRestaurant.setValue(detailVM.business?.review_count, forKey: "rating")
        savedRestaurant.setValue(detailVM.business?.location?.city, forKey: "city")
        savedRestaurant.setValue(detailVM.business?.coordinates?.latitude, forKey: "lat")
        savedRestaurant.setValue(detailVM.business?.coordinates?.longitude, forKey: "long")
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    private func checkDataForDelete(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BusinessCD")
        do {
            let results   = try context.fetch(fetchRequest)
            let businesses = results as! [BusinessCD]
            if businesses.count > 4 {
                if let lastObj = businesses.first {
                    context.delete((lastObj) as NSManagedObject)
                    try context.save()

                }
            }

            
        } catch let error as NSError {
            print("Could not fetch \(error)")
          }
    }
    
    
    
    func retriveData(completion: @escaping ([Business]) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BusinessCD")
        do {
            let results   = try context.fetch(fetchRequest)
            let businesses = results as! [BusinessCD]
            var businessObjArray = [Business]()
            for busines in businesses {
                var busniessObj = Business()
                busniessObj.id = busines.id
                busniessObj.name = busines.name
                busniessObj.image_url = busines.imageUrl
                busniessObj.location?.city = busines.city
                let coordinates = Coordinates(latitude: busines.lat, longitude: busines.long)
                busniessObj.coordinates = coordinates
                busniessObj.coordinates?.latitude = busines.lat
                busniessObj.coordinates?.longitude = busines.long
                busniessObj.review_count = Int(busines.rating)
                busniessObj.price = busines.price
                businessObjArray.append(busniessObj)
                
            }
            
            completion(businessObjArray)
             

        } catch let error as NSError {
          print("Could not fetch \(error)")
        }
    }
}
