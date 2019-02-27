//
//  PersonalViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/25/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var txt_name: UITextField!
    
    
    @IBOutlet weak var txt_phone: UITextField!
    
    
    @IBOutlet weak var btn_enter: UIButton!
    
    @IBOutlet weak var btn_cancel: UIButton!
    
    let shareActions = SharedFunctions()
    var delegate : PassData?
    var name = ""
    var phone = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shareActions.roundBorder(control: btn_enter, width: 1, color: UIColor.white.cgColor, radius: 15)
        
        shareActions.roundBorder(control: btn_cancel, width: 1, color: hexStringToUIColor(hex: "331E1A").cgColor, radius: 15)
        
    }
    
    

    
    @IBAction func enter(_ sender: UIButton) {
         name = txt_name.text!
         phone = txt_phone.text!
        if name.isEmpty || phone.isEmpty {
            showAlert(view: self, title: "Lỗi", alert: "Vui lòng điền đầy đủ tên và số điện thoại")
        }else {
             UserDefaults.standard.set(name, forKey: GlobalValues().user_name)
             UserDefaults.standard.set(phone, forKey: GlobalValues().user_phone)
        }
        
        if let delegate = self.delegate {
            delegate.passData(data: "Done")
        }
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: {})
       
    }
    
    @IBAction func cancel(_ sender: UIButton) {
    
       
        self.dismiss(animated: true, completion: {})
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
