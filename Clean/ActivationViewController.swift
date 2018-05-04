//
//  ActivationViewController.swift
//  Clean
//
//  Created by James on 7/4/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class ActivationViewController: UIViewController {

    @IBOutlet weak var txt_code: UITextField!
    
    @IBOutlet weak var lbl_message: UILabel!
    
    @IBOutlet weak var btn_activate: UIButton!
    
    @IBOutlet weak var txt_username: UITextField!
    
    var message = ""
    
     let border = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_activate.layer.borderColor = hexStringToUIColor(hex: "#565455").cgColor
        btn_activate.layer.borderWidth = 2
        btn_activate.layer.cornerRadius = 30
        btn_activate.backgroundColor = hexStringToUIColor(hex: "#565455")
        btn_activate.titleLabel?.numberOfLines = 0
        btn_activate.titleLabel?.minimumScaleFactor = 0.5
        
       
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: 35, width:  txt_code.frame.size.width, height: txt_code.frame.size.height)
        
        border.borderWidth = width
        txt_code.layer.addSublayer(border)
        txt_code.layer.masksToBounds = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        
    }
    
    func dismissKeyboard(){
        txt_code.resignFirstResponder()
        txt_username.resignFirstResponder()
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func activateApp(_ sender: UIButton) {
        
        let user = userValidate.ActivateUserToServer(code: txt_code.text!)
        
        if (user.message != ""){
            
            lbl_message.text = user.message
            lbl_message.textColor = UIColor.red
            lbl_message.textAlignment = .center
            border.borderColor = UIColor.red.cgColor
       
        }
        else {
            dataUser.AddUser(user.name, user.address, user.id, user.isActive, user.isBlocked, user.supervisor_id, user.code)
            
            //Update Device Token to Send Push Notification
            if (CFtoken != ""){
                let requestConent = ["id" : dataUser.GetUser()[0].id!, "token" : CFtoken ] as [String : Any]
                let link = Config.destination + "/function/updatetoken.php"
                
                server.sendHTTPrequsetWithData(requestConent, link)
            }

            let newViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
            self.present(newViewController, animated: true, completion: nil)
        }
        
    }
    
    
    
    func sendRequest(request: NSURLRequest) -> NSData {
        let session = URLSession.shared
        var dataReceived: NSData = NSData ()
        let sem = DispatchSemaphore(value: 0)
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print("Error -> \(String(describing: error))")
                return
            }
            
            dataReceived = data! as NSData
            sem.signal()
        }
        
        task.resume()
        
        // This line will wait until the semaphore has been signaled
        // which will be once the data task has completed
        sem.wait()
        return dataReceived
    }
    
    
    
}
