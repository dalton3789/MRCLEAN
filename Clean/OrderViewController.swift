//
//  OrderViewController.swift
//  Clean
//
//  Created by James on 7/6/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var txt_name: UITextField!
    
    
    
    @IBOutlet weak var txt_city: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    @IBOutlet weak var tvt_address: UITextView!

    
    @IBOutlet weak var txt_startDate: UITextField!
    
    @IBOutlet weak var txt_endDate: UITextField!
    
    
    @IBOutlet weak var txt_services: UITextField!
    @IBOutlet weak var tvt_note: UITextField!
    
    @IBOutlet weak var btn_order: UIButton!
    
    var selectService = ""
    var datepicker = UIDatePicker()

    
    let services = ["Vệ Sinh Định Kì" , "Vệ Sinh Sau Xây Dựng", "Vệ Sinh Chuyên Sâu", "Vệ Sinh Trước/Sau Khi Chuyển Nhà","Vệ Sinh Express"]
    
    var server = Server();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPicker()
        createDatePicker()
        // Do any additional setup after loading the view.
        //videoView.loadRequest(URLRequest(url: URL(string: "https://drive.google.com/open?id=0B0laj5YHRcM9QVp3U3lENlNFczg")!))
        tvt_address.layer.cornerRadius = 10
        tvt_address.layer.borderColor = UIColor.gray.cgColor
        tvt_address.layer.borderWidth = 1
        btn_order.layer.cornerRadius = 10
        btn_order.layer.borderColor = UIColor.white.cgColor
        btn_order.layer.borderWidth = 1
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        
    }
    
    func dismissKeyboard(){
        txt_city.resignFirstResponder()
        txt_name.resignFirstResponder()
        txt_phone.resignFirstResponder()
        tvt_address.resignFirstResponder()
        txt_endDate.resignFirstResponder()
        txt_startDate.resignFirstResponder()
        tvt_note.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createPicker(){
        
        let servicePicker = UIPickerView()
        servicePicker.delegate = self
        servicePicker.dataSource = self
        
        
        txt_services.inputView = servicePicker
    }
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem : .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,spaceButton], animated: false)
        
        txt_city.inputAccessoryView = toolbar
        
    }
    
    func doneClick(){
        txt_city.resignFirstResponder()
    }
    
    func donePressed(){
        txt_startDate.text = "\(datepicker.date)"
    }
    
    func donePressed1(){
        txt_endDate.text = "\(datepicker.date)"
    }
    

    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
         let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,  target: self, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,  target: self, action: #selector(donePressed1))
        
        toolbar1.setItems([doneButton1], animated: false)
        txt_startDate.inputAccessoryView = toolbar
        txt_startDate.inputView = datepicker
        txt_endDate.inputAccessoryView = toolbar1
        txt_endDate.inputView = datepicker

        
    }
    
  
    @IBAction func createOrder(_ sender: UIButton) {
        let request_content = ["email": txt_city.text!, "name":txt_name.text!, "phone":txt_phone.text!, "address" : tvt_address.text!, "startDate":txt_startDate.text!, "endDate":txt_endDate.text!, "note" : tvt_note.text!, "service" : txt_services.text!] as [String: Any]
        let link = Config.destination + "/function/createOrder.php"
        
        server.sendHTTPrequsetWithData(request_content, link)
        
        let alert = UIAlertController(title: "", message: "MR&MRS CLEAN Xin Cảm Ơn Yêu Cầu Dịch Vụ Từ Quý Khách. Nhân Viên Của Chúng Tôi Sẽ Liên Lạc Để Hỗ Trợ Yêu Cầu Dịch Vụ Của Quý Khách", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        //alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")}))
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    
}

/*
 // MARK: - Navigation
 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

extension OrderViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return services.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return services[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectService = services[row]
        txt_services.text = selectService
    }

}
