//
//  UpdateAccountViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/8/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class UpdateAccountViewController: UIViewController {

    
    @IBOutlet weak var txt_name: UITextField!
    
    
    @IBOutlet weak var txt_address: UITextField!
    
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    
    @IBOutlet weak var txt_password: UITextField!
    
    
    @IBOutlet weak var btn_update: UIButton!
    
    @IBOutlet weak var btn_cancel: UIButton!
    
    var dataDelegate : PassData?
    
    let shareAction = SharedFunctions()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shareAction.setBottomBorder(view: txt_name)
        shareAction.setBottomBorder(view: txt_email)
        shareAction.setBottomBorder(view: txt_phone)
        shareAction.setBottomBorder(view: txt_address)
        shareAction.setBottomBorder(view: txt_password)
        shareAction.roundBorder(control: btn_cancel, width: 1, color: hexStringToUIColor(hex: "331E1A").cgColor , radius: 15)
        shareAction.roundBorder(control: btn_update, width: 1, color: UIColor.clear.cgColor , radius: 15)
        
        
        txt_password.text = user.code!
        txt_address.text = user.address!
        txt_phone.text = user.phone!
        txt_email.text = user.email!
        txt_name.text = user.name!
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
 
    }
    

    @IBAction func update(_ sender: Any) {
        /*
        let request_content = ["email": txt_email.text!, "name": txt_name.text!, "phone": txt_phone.text!, "address" : txt_address.text!, "code": txt_password.text!] as [String: Any]
        let link = Config.destination + "/function/createcustomer.php"
        
        server.sendHTTPrequsetWithData(request_content, link)
        */
        //let newUser = User()
        user.address = txt_address.text!
        user.code = txt_password.text!
        user.email = txt_email.text!
        user.phone = txt_phone.text!
        user.name = txt_name.text!
        
        //dataUser.user = user
        
        dataUser.UpdateUser(user)
        dataDelegate?.passData(data: "Done")
        
        dismiss(animated: true, completion: {})
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: {})
    }
    
    func dismissKeyboard(){
        txt_phone.resignFirstResponder()
        txt_password.resignFirstResponder()
        txt_address.resignFirstResponder()
        txt_email.resignFirstResponder()
        txt_name.resignFirstResponder()
    }
    
}
