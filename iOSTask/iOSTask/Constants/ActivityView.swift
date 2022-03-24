//
//  ActivityView.swift
//  iOSTask
//
//  Created by nineleaps on 23/03/22.
//

import Foundation
import UIKit

var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

extension UIViewController {
    func activityIndicatorBegin() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

       
    }
    func activityIndicatorEnd() {
        activityIndicator.stopAnimating()
    }
    
}


