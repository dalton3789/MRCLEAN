//
//  MessageViewController.swift
//  Clean
//
//  Created by James on 8/5/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var tvt_chat: UITextView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var img_gif: UIImageView!
    
    @IBOutlet weak var btn_reply: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetAllMessage()
        UpdateResponse()
        
        btn_reply.backgroundColor = hexStringToUIColor(hex: "959595")
        btn_reply.layer.cornerRadius = 15
        btn_reply.layer.borderWidth = 1
        
        tvt_chat.layer.borderWidth = 1
        tvt_chat.layer.cornerRadius = 10
        tvt_chat.backgroundColor = hexStringToUIColor(hex: "959595")
        
        
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(MessageViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MessageViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        img_gif.loadGif(name: "Messenger")

    }
    
    func dismissKeyboard(){
        tvt_chat.resignFirstResponder()
    }

    //Relocate textbox above keyboard
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DeleteAllMessages(_ sender: UIButton) {
        dataUser.DeleteAllResponse()
        alertMain.message = "Lịch Sử Tin Nhắn Đã Được Xoá"
        self.present(alertMain, animated: true, completion: nil)
    }

  
    
    @IBAction func sendChat(_ sender: UIButton) {
        replyResposeFromMMC()
        alertMain.message = "Tin nhắn đã được gửi. Xin Cảm ơn Quý khách!"
        self.present(alertMain, animated: true, completion: nil)
        tvt_chat.text = ""
    }
    
    func UpdateResponse(){

        
        //Clear out List Messages
        CFListNewMessage.removeAll()
    }
    
    
    func replyResposeFromMMC(){

        
        dataUser.AddResponse(CFResponseFromMMC.id, CFResponseFromMMC.customer_id, CFResponseFromMMC.topic_id, tvt_chat.text!, CFResponseFromMMC.title, "1", "0", CFResponseFromMMC.time)
        let data = ["id": "", "customer_id" : (dataUser.GetUser().first?.id)!, "topic_id" : CFMessageTopicID , "content" : tvt_chat.text, "title" : "MR&MRS CLEAN thực hiện dịch vụ"] as [String: Any]

        
        let link = Config.destination + "/function/replyresponse.php"
        
        server.sendHTTPrequsetWithData(data, link)
        
  
    }
    
    

    
    func GetAllMessage(){
       let screenSize = UIScreen.main.bounds
        let viewaAuto = UIView()
        let listMessages = dataUser.GetRepsonseMessage()
        var i = 0
        for aa in listMessages{
            let labelChat = UILabel()
            let labelView = UIView()
            if (aa.isReplied != "0"){
                
                labelChat.frame = CGRect(x: 0 ,y: (31*i+35),width: Int(screenSize.width/1.3), height:80 )
                //label.center = view.center
                labelChat.textAlignment = NSTextAlignment.center
                //labelChat.backgroundColor = UIColor.gray
                labelChat.textColor = hexStringToUIColor(hex: "4d2600")
                labelChat.numberOfLines = 10
                labelChat.adjustsFontSizeToFitWidth = true
                //labelChat.layer.cornerRadius = 5
                //labelChat.layer.borderWidth = 1
                labelChat.text = "MR&MRS CLEAN : \n" + aa.content! + "\n Được gửi vào lúc : " + aa.time!
                
            }
            else{
                
                labelChat.frame = CGRect(x: 80 ,y: (31*i+35),width: Int(screenSize.width/1.3), height:90 )
                //label.center = view.center
                labelChat.textAlignment = NSTextAlignment.center
                //labelChat.backgroundColor = hexStringToUIColor(hex: "539e42")
                labelChat.textColor = hexStringToUIColor(hex: "539e42")
                labelChat.numberOfLines = 5
                labelChat.adjustsFontSizeToFitWidth = true
                //labelChat.layer.cornerRadius = 5
                //labelChat.layer.borderWidth = 1
                labelChat.text = "You : \n" + aa.content!
                

            }
            
            labelView.addSubview(labelChat)
            labelView.frame  = CGRect(x: 0, y: 120*i, width: Int(self.view.frame.width), height: 120*i)
            labelView.layer.cornerRadius = 20
            viewaAuto.addSubview(labelView)
            
            i = i + 1
           
        }
       
        scrollview.addSubview(viewaAuto)
        viewaAuto.frame = CGRect(x: 0, y: 10, width: Int(self.view.frame.width), height: 120*i + 400)
        scrollview.contentSize.height = viewaAuto.frame.height

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
