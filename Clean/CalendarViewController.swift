//
//  CalendarViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/27/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var view_Calendar: UIView!
    
    let calenderView: CalenderView = {
        let v=CalenderView(theme: MyTheme.light)
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    
    @IBOutlet weak var btn_ok: UIButton!
    
    @IBOutlet weak var txt_time: UITextField!
    
    @IBOutlet weak var quit: UIImageView!
    
    
    let shareAction = SharedFunctions()
    let globalVariables = GlobalValues()
    var passdateDelegate : PassData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createDatePicker()
        
        quit.isUserInteractionEnabled = true
        quit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissInput)))
        view_Calendar.addSubview(calenderView)
        calenderView.topAnchor.constraint(equalTo: view_Calendar.topAnchor, constant: 10).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view_Calendar.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view_Calendar.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalTo: view_Calendar.heightAnchor, multiplier: 1).isActive = true
        
        shareAction.roundBorder(control: btn_ok, width: 1, color: UIColor.clear.cgColor, radius: 15)
        
       // calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true
    }
    
    @objc func dissmissInput(){
        self.dismiss(animated: true, completion: {})
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem .done,  target: self, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        txt_time.inputAccessoryView = toolbar
        datepicker.datePickerMode = .time
        txt_time.inputView = datepicker
        
    }
  
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let selectedDate = dateFormatter.string(from: datepicker.date)
        txt_time.text = "\(selectedDate)"
        view.endEditing(true)
    }
    
    
    @IBAction func Done(_ sender: UIButton) {
       let selectedDate = calenderView.getSelectedDate()
        
        let dateTime = selectedDate + " " + txt_time.text!
        UserDefaults.standard.set(dateTime, forKey: globalVariables.booking_date)
        passdateDelegate?.passData(data: dateTime)
        dismiss(animated: true, completion: {})
    }
}
