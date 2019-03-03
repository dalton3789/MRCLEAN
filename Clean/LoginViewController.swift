//
//  LoginViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/1/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let shareActions = SharedFunctions()
    
    
    @IBOutlet weak var back: UIImageView!
    
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_login: UITextField!
    
    
    @IBOutlet weak var btn_login: UIButton!
    
    @IBOutlet weak var btn_signup: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shareActions.setBottomBorder(view: txt_email)
        shareActions.setBottomBorder(view: txt_login)
        shareActions.roundBorder(control: btn_login, width: 1, color: UIColor.clear.cgColor, radius: 15)
         shareActions.roundBorder(control: btn_signup, width: 1, color: hexStringToUIColor(hex: "331E1A").cgColor, radius: 15)
        
        back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( self.cancel)))
        back.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( self.cancelKeyboard)))
    }
    
   
    @objc func cancel(){
        self.dismiss(animated: true, completion: {})
    }
    @objc func cancelKeyboard(){
        txt_login.resignFirstResponder()
        txt_email.resignFirstResponder()
    }


}
