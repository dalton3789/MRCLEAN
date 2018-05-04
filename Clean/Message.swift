//
//  Message.swift
//  Clean
//
//  Created by James on 7/28/17.
//  Copyright © 2017 James. All rights reserved.
//

import Foundation

class Message{
    var datauser = DataUser()
    var server = Server()
    struct Response{
        var id = ""
        var customer_id = ""
        var content = ""
        var title = ""
        var time = ""
        var isRead = ""
        var isReplied = ""
        var topic_id = ""
        
    }
    
    func GetResponseFromServer() -> [Response]{
        do{
            let link = Config.destination + "/function/getresponse.php?id=" + datauser.GetUser()[0].id!
            let result = server.sendHTTPrequsetWitouthData(link)
            var arrayMessage : [Response] = []
            
            let parsedData = try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []) as? [String:AnyObject]
            
            
            if let Data = parsedData?["responses"] as? [[String : AnyObject]] {
                
                for event in Data {
                    var Message = Response()
                    Message.id = (event["id"] as! String)
                    Message.customer_id = (event["customer_id"] as! String)
                    Message.content = (event["content"] as! String)
                    Message.title = (event["title"] as! String)
                    Message.time = (event["time"] as! String)
                    Message.isRead = (event["isRead"] as! String)
                    Message.isReplied = (event["isReplied"] as! String)
                    Message.topic_id = (event["topic_id"] as! String)
                    
                    arrayMessage.append(Message)
                }
                
                return arrayMessage
            }
        }catch{
            print(error)
        }
        return []
    }
    
    func UpdateReadResponseToServer(_ id : String){
        let lnk_updateMessage = Config.destination + "/function/readresponse.php?id=" + id
        
        server.sendHTTPrequsetWitouthData(lnk_updateMessage)
    }


}
