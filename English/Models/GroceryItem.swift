//
//  GroceryItems.swift
//  English
//
//  Created by Lê Duy on 9/17/18.
//  Copyright © 2018 Lê Duy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct GroceryItem {
    var amountOfUnit : Int = 0
    var nameUnit = [String]()
    
    init?(value: DataSnapshot) {
        if value.key == "amountOfUnit" {
            guard let amountUnit = value.value as? Int else {return}
            self.amountOfUnit = amountUnit
            
        } else {
            guard let unitInfo = value.value as? [String:AnyObject] else {return}
            guard let title = unitInfo["title"] as? String else {return}
            nameUnit.append(title)
        }
        
    }
    
    init() {}
    
}
