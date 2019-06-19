//
//  SendMessagePopupViewController.swift
//  Clean
//
//  Created by Dalton Nguyen on 6/19/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class SendMessagePopupViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var txt_message: UITextView!
    var isEdited  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txt_message.delegate = self
        SharedFunctions().roundBorder(control: txt_message, width: 1, color: UIColor.lightGray.cgColor, radius: 10)
    }
    

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if isEdited == false {
            isEdited = true
            textView.text = ""
            textView.textColor = hexStringToUIColor(hex: "331E1A")
        }
    }
    
    func sendMessage(){
        let numRespones = dataUser.GetRepsonseMessage()
        let shareAction = SharedFunctions()
        dataUser.AddResponse(String(numRespones.count + 1), CFResponseFromMMC.customer_id, CFResponseFromMMC.topic_id, txt_message.text!, CFResponseFromMMC.title, "0", "0",shareAction.getCurrentDate() + " , " + shareAction.getCurrentTime())
   
      //  let data = ["id": "", "customer_id" : (dataUser.GetUser().first?.id)!, "topic_id" : "" , "content" : txt_message.text!, "title" : "Tin nhan tu khach hang", "dToken" : CFtoken] as [String: Any]
        
         let data = ["id": "", "customer_id" : "28", "topic_id" : "" , "content" : txt_message.text!, "title" : "Tin nhan tu khach hang", "dToken" : CFtoken] as [String: Any]
        let link = Config.destination + "/function/replyresponse.php"
        
        server.sendHTTPrequsetWithData(data, link)
 
    }
}
