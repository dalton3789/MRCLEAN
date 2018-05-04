//
//  CustomerViewController.swift
//  Clean
//
//  Created by James on 7/7/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit
import UserNotifications

class CustomerViewController: UIViewController {

    @IBOutlet weak var btn_icon: UIButton!
    
    @IBOutlet weak var btn_sendRequest: UIButton!
    
    
    @IBOutlet weak var btn_renewContract: UIButton!
    
    
    @IBOutlet weak var btn_changeTime: UIButton!
    
     
    @IBOutlet weak var lbl_message: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //btn_renewContract.isEnabled = false
        
        //Check unread message from Server
        checkNewResponse()
        
        
        
        //Resend Token To Server
        sendRefreshToken()
  
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func checkNewResponse() {
        
        DispatchQueue.global(qos: .background).async {
            // Get Message From Server and Save To Local Data
            let listReponse = response.GetResponseFromServer()
            
            let listFromData = dataUser.GetRepsonseMessage()
            if (listFromData.count > 0 && listReponse.count > 0){
                for index in listReponse{
                    
                    for i in listFromData{
                        
                        
                        if (index.id != i.id!){
                            dataUser.AddResponse(index.id, index.customer_id, index.topic_id, index.content, index.title, index.isRead, index.isReplied, index.time)
                            
                            newMessage.content = index.content
                            newMessage.id = index.id
                            newMessage.customer_id = index.customer_id
                            newMessage.topic_id = index.topic_id
                            newMessage.title = index.title
                            newMessage.isReplied = index.isReplied
                            newMessage.time = index.time
                            
                            CFListNewMessage.append(newMessage)
                            DispatchQueue.global().sync {
                                 response.UpdateReadResponseToServer(index.id)
                            }
                            
                        }
                        
                    }
                }
            }
            else if (listFromData.count == 0 && listReponse.count > 0) {
                for index in listReponse{
                    dataUser.AddResponse(index.id, index.customer_id, index.topic_id, index.content, index.title, index.isRead, index.isReplied, index.time)
                    
                    newMessage.content = index.content
                    newMessage.id = index.id
                    newMessage.customer_id = index.customer_id
                    newMessage.topic_id = index.topic_id
                    newMessage.title = index.title
                    newMessage.isReplied = index.isReplied
                    newMessage.time = index.time
                    CFListNewMessage.append(newMessage)

                }
            }
            
          
            
            DispatchQueue.main.async {
                let messageCount = CFListNewMessage.count
                if (messageCount == 0)
                {
                    self.lbl_message.text = "TIN NHẮN"
                    self.lbl_message.textColor = UIColor.black
                }
                else {
                    self.lbl_message.text =  "CÓ TIN NHẮN MỚI"
                     self.lbl_message.textColor = UIColor.orange
                     CFMessageTopicID =  (CFListNewMessage.last?.topic_id)!
                }
                
            }
            
            
        }
        
        
    }

    
    
    func sendRefreshToken(){
        print( "Token is : " +  CFtoken)
        if (!CFtoken.isEmpty && isSendTokenToServer==0) {
            
            let requestConent = ["id" : dataUser.GetUser()[0].id!, "token" : CFtoken ] as [String : Any]
            let link = Config.destination + "/function/updatetoken.php"
            
            server.sendHTTPrequsetWithData(requestConent, link)
            isSendTokenToServer = 1;
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
