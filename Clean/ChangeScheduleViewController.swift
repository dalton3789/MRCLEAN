//
//  ChangeScheduleViewController.swift
//  Clean
//
//  Created by James on 7/18/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class ChangeScheduleViewController: UIViewController {

    @IBOutlet weak var txt_newDate: UITextField!
    
    
    @IBOutlet weak var tvt_detail: UITextView!
    @IBOutlet weak var btn_confirm: UIButton!
    
    
   
    
    @IBOutlet weak var img_gif: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

        img_gif.loadGif(name: "Calendar")
        
        btn_confirm.layer.borderColor = hexStringToUIColor(hex: "534741").cgColor
        btn_confirm.backgroundColor = hexStringToUIColor(hex: "534741")
        btn_confirm.layer.borderWidth = 1
        btn_confirm.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard(){
        txt_newDate.resignFirstResponder()
        tvt_detail.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSchedule(_ sender: UIButton) {
        let requestConent = ["id" : dataUser.GetUser()[0].id!, "request" : "Ngày đổi lịch : " + txt_newDate.text! + ", " + tvt_detail.text, "type" : "Yêu Cầu Đặc Biệt" ] as [String : Any]
        let link = Config.destination + "/function/sendrequest.php"
        
        server.sendHTTPrequsetWithData(requestConent, link)

        alertMain.message = "Yêu cầu đã được gửi. Xin cảm ơn quý khách!"
        
        self.present(alertMain, animated: true, completion: nil)
        txt_newDate.text = ""
        tvt_detail.text = ""
    }
    

    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
               toolbar.setItems([doneButton], animated: false)
        
        txt_newDate.inputAccessoryView = toolbar
        
    }
    
    func doneClick(){
        txt_newDate.resignFirstResponder()
    }
    
    func donePressed(){
        txt_newDate.text = "\(datepicker.date)"
    }
    

    
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,  target: self, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        txt_newDate.inputAccessoryView = toolbar
        txt_newDate.inputView = datepicker
        
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
