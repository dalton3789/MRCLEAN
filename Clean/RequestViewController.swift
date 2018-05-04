//
//  RequestViewController.swift
//  Clean
//
//  Created by James on 7/4/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet weak var tvt_specialRequest: UITextView!
    
    @IBOutlet weak var btn_send: UIButton!
    
    @IBOutlet weak var txt_feedbackType: UITextField!
    
    @IBOutlet weak var img_gif: UIImageView!
    
    
    var selectService = ""
    
    weak var datepicker = UIDatePicker()

    let feedback = ["","Yêu Cầu Đặc Biệt" , "Phản Hồi Về Dịch Vụ", "Thông Báo Khác"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_send.layer.borderColor = UIColor.white.cgColor
        btn_send.layer.borderWidth = 2
        btn_send.layer.cornerRadius = 40
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        createPicker()
        //subView.isHidden = true
        
        let border = CALayer()
        border.borderColor = hexStringToUIColor(hex: "959595").cgColor
        border.frame = CGRect(x: 0, y: txt_feedbackType.frame.size.height - 1 , width:  txt_feedbackType.frame.size.width, height: txt_feedbackType.frame.size.height)

        
        border.borderWidth = 1
        txt_feedbackType.layer.addSublayer(border)
        txt_feedbackType.layer.masksToBounds = true
        
       // lbl_line.textColor = hexStringToUIColor(hex: "959595")
        

        
        img_gif.loadGif(name: "sendrequest")

        
    }
    func createPicker(){
        
        let servicePicker = UIPickerView()
        servicePicker.delegate = self
        servicePicker.dataSource = self
        
        
        txt_feedbackType.inputView = servicePicker
    }
    
    func dismissKeyboard(){
        tvt_specialRequest.resignFirstResponder()
        txt_feedbackType.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func sendRequestToServer(_ sender: UIButton) {
        
        
            weak var user = dataUser.GetUser().first!
            
            let data = ["id" : user?.id! , "request" : self.tvt_specialRequest.text!, "type" : self.txt_feedbackType.text! ] as [String: Any]
            
            server.sendHTTPrequsetWithData(data,Config.destination + "/function/sendrequest.php" )
            

            self.btn_send.isEnabled = false

            
            alertMain.message = "Yêu cầu đã được gửi. Xin cảm ơn quý khách!"
            self.present(alertMain, animated: true, completion: nil)
           self.tvt_specialRequest.text! = ""
 
            
        
    }
    

   
}
extension RequestViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return feedback.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return feedback[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectService = feedback[row]
        txt_feedbackType.text = selectService
    }
    
}
