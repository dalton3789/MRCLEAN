//
//  Order.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/20/19.
//  Copyright © 2019 James. All rights reserved.
//

import Foundation

public class Order {
    var name : String
    var address : String
    var phone : String
    var date : String
    var totalTime : String
    var totalCost : String
    var note : String
    
    public init() {
        name = ""
        address = ""
        phone = ""
        date = ""
        totalTime = ""
        totalCost = ""
        note = ""
    }
}
