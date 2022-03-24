//
//  Reachability.swift
//  iOSTask
//
//  Created by nineleaps on 24/03/22.
//

import Foundation
import Network

class Reachability {
    
    static let shared = Reachability()

    let monitor = NWPathMonitor()
    private var status : Bool?

    
    
    func checkNetwork(completion: @escaping (Bool) -> Void){
        monitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
            completion(true)
           } else {
            completion(false)
              print("Disconnected")
           }
           print(path.isExpensive)
        }
    }
    func startMonitoring(){
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
   
}
