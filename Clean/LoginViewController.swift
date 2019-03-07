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

    @IBAction func sign_in(_ sender: UIButton) {
        let result = validateText()
        if !result.0 {
            shareActions.showErrorToast(message: result.1, view: self.view, startY: (self.navigationController?.navigationBar.frame.height)!, endY: (self.navigationController?.navigationBar.frame.height)! + 45)
        }else {
            
        }
    }
    
    func validateText() -> (Bool,String) {
        let email = txt_email.text!
        let pass = txt_login.text!
        if email.isEmpty{
            return (false, "Vui lòng nhập địa chỉ email")
        }else {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            let result = emailPredicate.evaluate(with: email)
            if !result {
                return (false, "Địa chỉ email không chính xác")
            }
        }
        if pass.isEmpty{
            return (false, "Vui lòng nhập password")
        }
        
        return(true, "")
    }
    
    

}
