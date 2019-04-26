//
//  AddTripExt.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/25/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation
import UIKit

extension AddTripViewController {
    
    func displayAlert(title: String?, msg: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController.init(title: title, message: msg, preferredStyle: style)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
