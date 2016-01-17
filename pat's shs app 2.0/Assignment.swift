//
//  Assignment.swift
//  Planner
//
//  Created by Daniel Bessonov on 11/7/15.
//  Copyright © 2015 Daniel Bessonov. All rights reserved.
//

import Foundation
import UIKit

class Assignment: NSObject {
    let name : String
    var dueDate : String
    init(name: String, dueDate : String)
    {
        self.name = name
        self.dueDate = dueDate
    }
    
}

