//
//  BookHourServiceViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 5/6/18.
//  Copyright © 2018 James. All rights reserved.
//

import UIKit

class BookHourServiceViewController: UIViewController {

    @IBOutlet weak var txt_name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    @IBOutlet weak var txt_address: UITextView!
    
    @IBOutlet weak var txt_date: UITextField!
    
    @IBOutlet weak var txt_starttime: UITextField!
    
    @IBOutlet weak var txt_endTime: UITextField!
    
    @IBOutlet weak var txt_note: UITextView!

    @IBOutlet weak var btn_confirm: UIButton!
    
    @IBOutlet weak var btn_cancel: UIButton!
    
    @IBOutlet weak var lbl_total: UILabel!
    
    @IBOutlet weak var lbl_error: UILabel!
    
    
    var datepicker = UIDatePicker()
    var timepicker = UIDatePicker()
    
    var startHour : Int?
    var startMin : Int?
    var endHour : Int?
    var endMin : Int?
    var isInputAll = 0
    
    var request = ServiceRequest()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_total.isHidden = true
        lbl_error.isHidden = true

        createDatePicker()
        createTimePicker()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
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
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,  target: self, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)

        txt_date.inputAccessoryView = toolbar
        datepicker.datePickerMode = .date
        txt_date.inputView = datepicker
 
    }
    
    func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = dateFormatter.string(from: datepicker.date)
        txt_date.text = "\(selectedDate)"
        view.endEditing(true)
    }
    
    
    func createTimePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,  target: self, action: #selector(donePressedTime))
        
        toolbar.setItems([doneButton], animated: false)
        timepicker.datePickerMode = .time
        
        txt_starttime.inputAccessoryView = toolbar
        txt_starttime.inputView = timepicker
        
        
        let toolbar1 = UIToolbar()
        toolbar1.sizeToFit()
        let doneButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,  target: self, action: #selector(donePressedTime1))
        
        toolbar1.setItems([doneButton1], animated: false)
        
        
        
        txt_endTime.inputAccessoryView = toolbar1
        txt_endTime.inputView = timepicker
    }
    
   @objc func donePressedTime(){
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: timepicker.date)
        startHour = comp.hour
        startMin = comp.minute
        
        txt_starttime.text = String(startHour!) + ":" + String(startMin!)
        view.endEditing(true)
    }
    
    func donePressedTime1(){
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: timepicker.date)
        endHour = comp.hour
        endMin = comp.minute
        
        txt_endTime.text = String(endHour!) + ":" + String(endMin!)
        view.endEditing(true)
    }
    
    
    func dismissKeyboard(){
        txt_address.resignFirstResponder()
        txt_name.resignFirstResponder()
        txt_phone.resignFirstResponder()
        txt_endTime.resignFirstResponder()
        txt_starttime.resignFirstResponder()
        txt_date.resignFirstResponder()
        txt_note.resignFirstResponder()
        email.resignFirstResponder()
    }

    @IBAction func confirmService(_ sender: UIButton) {
        lbl_total.isHidden = true
        lbl_error.isHidden = true
        
        enterInputValidation()
  }
    
    
    func validateAll(){
        lbl_total.isHidden = true
        lbl_error.isHidden = true
        
        let hourInterval = endHour! - startHour!
        let minInterval = Float( abs(endMin! - startMin!))/Float(60)
        let timeInterval = Float(hourInterval) + Float(minInterval)
        
        
        
        if (endHour! < startHour!){
            lbl_error.text = "Giờ kết thúc phải lớn hơn giờ bắt đầu"
            lbl_error.isHidden = false
        }
        else if (timeInterval < 2){
            lbl_error.text = "Vui lòng đặt dịch vụ tối thiểu 2 giờ"
            lbl_error.isHidden = false
            
        }
        else{
            let total = timeInterval * 699.000
            lbl_total.text = "Thành Tiền : " + String(total) + "00 VND/ 2 nghiệp vụ"
            
            request.address = txt_address.text
            request.date = txt_date.text!
            request.startTime = txt_starttime.text!
            request.name = txt_name.text!
            request.email = email.text!
            request.endTime = txt_endTime.text!
            request.note = txt_note.text!
            request.phone = txt_phone.text!
            request.total = "Thành Tiền : " + String(total) + "00 VND/ 2 nghiệp vụ"
            
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReviewRequestViewController") as! ReviewRequestViewController
            
            newViewController.request = request
            self.present(newViewController, animated: true, completion: nil)
            
            
        }
        
    }
    
    @IBAction func cancelRequest(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func enterInputValidation(){
        isInputAll = 0
        if (!(txt_name.text?.isEmpty)! && !(txt_address.text?.isEmpty)! && !(txt_phone.text?.isEmpty)! && !(txt_date.text?.isEmpty)! && !(txt_starttime.text?.isEmpty)! && !(txt_endTime.text?.isEmpty)! ){
            isInputAll = 1
            validateAll()
        }
        else{
            lbl_error.text = "Vui lòng nhập đầy đủ các thông tin!"
            lbl_error.isHidden = false
        }
    }
    
}
