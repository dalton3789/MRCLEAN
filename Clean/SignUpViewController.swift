//
//  SignUpViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/1/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_name: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    @IBOutlet weak var txt_address: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    @IBOutlet weak var btn_signup: UIButton!
    
    
    @IBOutlet weak var img_back: UIImageView!
    
    let shareAction = SharedFunctions()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shareAction.roundBorder(control: btn_signup, width: 1, color: UIColor.clear.cgColor, radius: 15)
        shareAction.setBottomBorder(view: txt_email)
        shareAction.setBottomBorder(view: txt_phone)
        shareAction.setBottomBorder(view: txt_name)
        shareAction.setBottomBorder(view: txt_address)
        shareAction.setBottomBorder(view: txt_password)
        
        img_back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( self.cancel)))
        img_back.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( self.cancelKeyboard)))
    }
    
    
    @objc func cancel(){
       // performSegue(withIdentifier: "segue_backtologin", sender: self)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @objc func cancelKeyboard(){
        txt_phone.resignFirstResponder()
        txt_email.resignFirstResponder()
        txt_name.resignFirstResponder()
        txt_address.resignFirstResponder()
        txt_password.resignFirstResponder()
    }

    func validAllTextBox() -> (Bool,String) {
        let email = txt_email.text!
        let phone = txt_phone.text!
        var result = false
        if !email.isEmpty {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            result = emailPredicate.evaluate(with: email)
            if !result {
                return (result, "Địa chỉ email không chính xác")
            }
        }else if email.isEmpty{
             return (false, "Vui lòng nhập địa chỉ email")
        }
        if !phone.isEmpty {
            do {
                let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
                let matches = detector.matches(in: phone, options: [], range: NSMakeRange(0, phone.count))
                if let res = matches.first {
                    result = res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == phone.count
                } else {
                    return (false, "Số điện thoại chưa đúng")
                }
            } catch {
                return (false, "Số điện thoại chưa đúng")
            }
        }else if phone.isEmpty{
            return(false,"Vui lòng nhập số điện thoại")
        }
        if (txt_address.text?.isEmpty)!{
            return(false, "Vui lòng nhập địa chỉ")
        }
        if (txt_password.text?.isEmpty)!{
            return(false, "Vui lòng nhập password")
        }
        if (txt_name.text?.isEmpty)!{
            return(false, "Vui lòng nhập họ và tên")
        }
        return(true, "")
    }
    
   
    
   
    @IBAction func register(_ sender: UIButton) {
        
        
        let result = validAllTextBox()
        
        if !result.0{
            showAlert(view: self, title: "Lỗi", alert: result.1)
        }else {
            dataUser.DeleteAllUser()
            dataUser.AddUser(txt_name.text!, txt_address.text!, "1", true, false, "1", txt_password.text!, txt_phone.text!)
            performSegue(withIdentifier: "home_segue", sender: self)
        }
        
        
    }
    

}
