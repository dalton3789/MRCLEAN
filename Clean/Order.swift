//
//  Order.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/20/19.
//  Copyright © 2019 James. All rights reserved.
//

import Foundation
import CoreData
import UIKit


public class Order {
    var name : String
    var address : String
    var phone : String
    var date : String
    var totalTime : String
    var totalCost : String
    var note : String
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bookingArray = [Booking]()
    var booking = Booking()
    
    public init() {
        name = ""
        address = ""
        phone = ""
        date = ""
        totalTime = ""
        totalCost = ""
        note = ""
    }
    
    
    public func GetBookings() -> [Booking]{
        var bookings = [Booking]()
        do{
            
            try bookings = context.fetch(Booking.fetchRequest())
        }
        catch{
            print(error)
        }
        
        return bookings
        
    }
    
    public func AddBooking(_ name: String, _ address: String, _ id:String, _ phone: String, _ date : String, _ totalTime : String , _ totalCost : String, _ note : String, _ review : String) {
        let newBooking = NSEntityDescription.insertNewObject(forEntityName: "Booking", into: context)
        newBooking.setValue(name, forKey: "name")
        newBooking.setValue(address, forKey: "address")
        newBooking.setValue(id, forKey: "id")
        newBooking.setValue(phone, forKey: "phone")
        newBooking.setValue(date, forKey: "date")
        newBooking.setValue(totalTime, forKey: "totalTime")
        newBooking.setValue(totalCost, forKey: "totalCost")
        newBooking.setValue(note, forKey: "note")
        newBooking.setValue(review, forKey: "review")
        
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        
    }
    
    public func DeleteAllBookings(){
        do{
            
            try bookingArray = context.fetch(Booking.fetchRequest())
            for booking in bookingArray as [NSManagedObject] {
                
                
                context.delete(booking)
                
            }
            try context.save()
        }
        catch{
            print(error)
        }
        
        
    }
    
    public func UpdateBooking(_ updatedBooking: Booking) {
        self.booking = updatedBooking
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    
}
