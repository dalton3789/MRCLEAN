//
//  UserValidation.swift
//  Clean
//
//  Created by James on 7/28/17.
//  Copyright © 2017 James. All rights reserved.
//

import Foundation

class UserValidation{
    
    var dataUser = DataUser()
    var server = Server()
    
    struct Customer{
        var id = ""
        var name = ""
        var code = ""
        var address = ""
        var isActive = true
        var isBlocked = false
        var supervisor_id = ""
        var message = ""

    
    }
    
    var CustomerInfo = Customer()
    
    func GetUserInfo() -> User {
        return dataUser.GetUser()[0]
    }
    
    func IsUserBlocked() -> Bool {
        return GetUserInfo().isBlocked
    }
    
    func IsUserActive() -> Bool{
        return GetUserInfo().isActive
    }
    
    func GetUserInfoFromServer() -> Customer{
        do {
            
        let  link = Config.destination + "/function/getcustomerbyid.php?id=" + GetUserInfo().id!
        let result = server.sendHTTPrequsetWitouthData(link)
        
        let parsedData = try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []) as? [String:AnyObject]
        
        
        if let Data = parsedData?["customers"] as? [[String : AnyObject]] {
            
            for event in Data {
                CustomerInfo.id = (event["id"] as! String)
                CustomerInfo.name = (event["name"] as! String)
                CustomerInfo.code = (event["code"] as! String)
                CustomerInfo.supervisor_id = (event["supervisor_id"] as! String)
                CustomerInfo.address = (event["address"] as! String)
                CustomerInfo.isActive = (Int(event["isActive"] as! String) ) != 0
                CustomerInfo.isBlocked = (Int(event["isBlocked"] as! String) ) != 0

            }
            return CustomerInfo
        }
        }catch{
            print(error)
        }
        return CustomerInfo
    }
    

    
    func UpdateUserData(_ user: Customer){
        
        if (user.id != "" ){
        dataUser.DeleteAllUser()
        
        dataUser.AddUser(user.name, user.address, user.id, user.isActive, user.isBlocked, user.supervisor_id, user.code, "", "")
        }
        
    }
    

    func ActivateUserToServer(code : String) -> Customer{
        var CustomerInformation = Customer()
        do {
            
            let  link = Config.destination + "/function/activateuser.php?code=" + code
            let result = server.sendHTTPrequsetWitouthData(link)
            
            let parsedData = try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []) as? [String:AnyObject]
            
            
            if let Data = parsedData?["customers"] as? [[String : AnyObject]] {
                
                for event in Data {
                    CustomerInformation.id = (event["id"] as! String)
                    CustomerInformation.name = (event["name"] as! String)
                    CustomerInformation.code = (event["code"] as! String)
                    CustomerInformation.supervisor_id = (event["supervisor_id"] as! String)
                    CustomerInformation.address = (event["address"] as! String)
                    CustomerInformation.isActive = (Int(event["isActive"] as! String) ) != 0
                    CustomerInformation.isBlocked = (Int(event["isBlocked"] as! String) ) != 0
                    CustomerInformation.message = (event["message"] as! String)
                    
                }
                return CustomerInformation
            }
        }catch{
            print(error)
        }
        return CustomerInformation
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
