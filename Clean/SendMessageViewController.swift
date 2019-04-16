//
//  SendMessageViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/1/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class SendMessageViewController: UIViewController {
   

    @IBOutlet weak var txt_message: UITextView!
    
   
    @IBOutlet weak var done: UIButton!
    
    let shareAction = SharedFunctions()
    
    var passDelegate : PassData?
    
    
    
    @IBOutlet weak var img_close: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareAction.view = self.view
        shareAction.allignKeyboard()

        shareAction.roundBorder(control: done, width: 1, color: UIColor.clear.cgColor, radius: 15)
        shareAction.roundBorder(control: txt_message, width: 1, color: UIColor.clear.cgColor, radius: 15)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        img_close.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeView)))

        img_close.isUserInteractionEnabled = true
        
       
    }
    
    @objc func dismissKeyboard(){
        txt_message.resignFirstResponder()
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: {})
    }
    

    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }

   
    @IBAction func donw(_ sender: UIButton) {
        let numRespones = dataUser.GetRepsonseMessage()
        
        dataUser.AddResponse(String(numRespones.count + 1), CFResponseFromMMC.customer_id, CFResponseFromMMC.topic_id, txt_message.text!, CFResponseFromMMC.title, "0", "0",shareAction.getCurrentDate() + " , " + shareAction.getCurrentTime())
        
        let data = ["id": "", "customer_id" : (dataUser.GetUser().first?.id)!, "topic_id" : "" , "content" : txt_message.text!, "title" : "Tin nhan tu khach hang", "dToken" : CFtoken] as [String: Any]
        
        
        let link = Config.destination + "/function/replyresponse.php"
        
        server.sendHTTPrequsetWithData(data, link)
        
        passDelegate?.passData(data: "Done")
        
        self.dismiss(animated: true, completion: {})
        
    }
    
    
    
   
}
