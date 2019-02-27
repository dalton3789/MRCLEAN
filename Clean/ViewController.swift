 //
//  ViewController.swift
//  Clean
//
//  Created by James on 7/4/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit
import UserNotifications
 



class ViewController: UIViewController {

    let x = 1;

    @IBOutlet weak var btn_info: UIButton!
    @IBOutlet weak var btn_customer: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // dataUser.DeleteAllUser()
        UpdateData()
        
        //videoView.loadRequest(URLRequest(url: URL(string: "https://google.com")!))
        
        if (isInit == 0)
        {
            Initialize()
        }

        btn_customer.layer.borderColor = hexStringToUIColor(hex: "#2d2d2d").cgColor
        btn_customer.layer.borderWidth = 2
        btn_customer.layer.cornerRadius = 15
        btn_customer.backgroundColor = hexStringToUIColor(hex: "331E1A")
        btn_info.layer.borderColor = hexStringToUIColor(hex: "#331E1A").cgColor
        btn_info.layer.borderWidth = 2
        btn_info.layer.cornerRadius = 15
        btn_info.setTitleColor(hexStringToUIColor(hex: "#331E1A"), for: .normal)

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    


    @IBAction func sleeping(_ sender: Any) {
        validateUser()
        
    }
    
    func UpdateData(){
        /*if (dataUser.GetUser().count > 0) {
            DispatchQueue.global(qos: .background).async {
                let user = userValidate.GetUserInfoFromServer()
                userValidate.UpdateUserData(user)
            }
            // Set to run background thread to check new message from server}*/

    }
    
    func validateUser(){
        if (dataUser.CountUser() == 0){
           
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ActivationViewController") as! ActivationViewController
            self.present(newViewController, animated: true, completion: nil)

        }
            //Check if customer is blocked
        else{
            
            if (userValidate.IsUserBlocked()){
                
                alertMain.message = "Tài Khoản Của Quý Khách Đã Bị Khoá. Xin Vui Lòng Liên Hệ Hotline Để Được Hỗ Trợ. Xin Cảm Ơn Quý Khách!"
                self.present(alertMain, animated: true, completion: nil)
                
            }
            else{
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
                self.present(newViewController, animated: true, completion: nil)
            }
            
        }
    }
    
    
    
 }

