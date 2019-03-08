//
//  DataModification.swift
//  Data
//
//  Created by James on 7/2/17.
//  Copyright © 2017 James. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataUser{
    
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userArray :[User] = []
    var responseArray :[ResponseMMC] = []
    
    public func AddUser(_ name: String, _ address: String, _ id:String, _ isActive: Bool, _ isBlocked : Bool, _ supervisor_id : String , _ code : String, _ phone : String, _ email : String) {
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue(name, forKey: "name")
        newUser.setValue(address, forKey: "address")
        newUser.setValue(id, forKey: "id")
        newUser.setValue(isActive, forKey: "isActive")
        newUser.setValue(isBlocked, forKey: "isBlocked")
        newUser.setValue(supervisor_id, forKey: "supervisor_id")
        newUser.setValue(code, forKey: "code")
        newUser.setValue(phone, forKey: "phone")
        newUser.setValue(email, forKey: "email")
        
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        
    }
    
    
    public func GetUser() -> [User]{
        do{
            
            try userArray = context.fetch(User.fetchRequest())
        }
        catch{
            print(error)
        }
        
        return userArray
        
    }
    
    public func CountUser() -> Int{
        do{
            
            return try context.count(for: User.fetchRequest())
        }
        catch{
            print(error)
        }
        
        return 0
    }
    
    public func DeleteUser(_ id: String){
        do{
            
            try userArray = context.fetch(User.fetchRequest())
            for user in userArray as [NSManagedObject] {
                
                if (String(describing: user.value(forKey: "id")!) == id)
                {
                    
                    context.delete(user)
                }
            }
            try context.save()
        }
        catch{
            print(error)
        }
        
        
    }
    
    public func DeleteAllUser(){
        do{
            
            try userArray = context.fetch(User.fetchRequest())
            for user in userArray as [NSManagedObject] {
                
             
                    context.delete(user)
                
            }
            try context.save()
        }
        catch{
            print(error)
        }
        
        
    }

    
    public func AddResponse( _ id : String, _ customer_id : String, _ topic_id : String, _ content : String, _ title : String, _ isRead : String, _ isReplied: String, _ time : String){
        
        let newResponse = NSEntityDescription.insertNewObject(forEntityName: "ResponseMMC", into: context)
        newResponse.setValue(id, forKey: "id")
        newResponse.setValue(customer_id, forKey: "customer_id")
        newResponse.setValue(topic_id, forKey: "topic_id")
        newResponse.setValue(title, forKey: "title")
        newResponse.setValue(time, forKey: "time")
        newResponse.setValue(content, forKey: "content")
        newResponse.setValue(isReplied, forKey: "isReplied")
        newResponse.setValue(isRead, forKey: "isRead")
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }

    }
    
    public func GetRepsonseMessage() -> [ResponseMMC]{
        do{
        
        try responseArray = context.fetch(ResponseMMC.fetchRequest())
        
        
        return responseArray
        } catch{
            print(error)
        }
        return []
        
    }
    
    public func DeleteAllResponse(){
        do{
            
            try responseArray = context.fetch(ResponseMMC.fetchRequest())
            for user in responseArray as [NSManagedObject] {
                
                
                context.delete(user)
                
            }
            try context.save()
        }
        catch{
            print(error)
        }
        
        
    }
    
    public func DeleteResponse(_ id: String){
        do{
            
            try responseArray = context.fetch(ResponseMMC.fetchRequest())
            for user in responseArray as [NSManagedObject] {
                if (String(describing: user.value(forKey: "id")!) == id)
                {
                context.delete(user)
                }
                
            }
            try context.save()
        }
        catch{
            print(error)
        }
        
        
    }


    
    
    
}
