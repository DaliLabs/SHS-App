//
//  Assignment.swift
//  Planner
//
//  Created by Daniel Bessonov on 11/7/15.
//  Copyright © 2015 Daniel Bessonov. All rights reserved.
//

import Foundation
import UIKit

class Assignment: NSObject, NSCoding {
    let name : String
    var dueDate : String
    init(name: String, dueDate : String)
    {
        self.name = name
        self.dueDate = dueDate
    }
    
    
    required init(coder decoder : NSCoder)
    {
        self.name = decoder.decodeObjectForKey("name") as! String
        self.dueDate = decoder.decodeObjectForKey("dueDate") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.dueDate, forKey: "dueDate")
    }

}

