//
//  Step1ViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/20/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class Step1ViewController: UIViewController {

    @IBOutlet weak var txt_dateTime: UITextField!
    
    @IBOutlet weak var txt_total: UITextField!
    
    @IBOutlet weak var txt_note: UITextView!
    
    @IBOutlet weak var btn_done: UIButton!
    
    @IBOutlet weak var lbl_cost: UILabel!
    
    @IBOutlet weak var lbl_totalTime: UILabel!
    
    @IBOutlet weak var lbl_totalCost: UILabel!
    
    
    
    let dataPicker = PickerDifinition()
    var picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dissmissInput)))
        dataPicker.values = ["2", "3" , "4" , "5" ,"6" ,"7" ,"8"]
        dataPicker.selectAction = setTextAfterSelected
        picker.delegate = dataPicker
        picker.dataSource = dataPicker
        txt_total.inputView = picker
        
        // Do any additional setup after loading the view.
    }
    
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,  target: self, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        txt_dateTime.inputAccessoryView = toolbar
        datepicker.datePickerMode = .dateAndTime
        txt_dateTime.inputView = datepicker
        
    }
    
    func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm"
        let selectedDate = dateFormatter.string(from: datepicker.date)
        txt_dateTime.text = "\(selectedDate)"
        view.endEditing(true)
    }
    
    func dissmissInput(){
        txt_dateTime.resignFirstResponder()
        txt_total.resignFirstResponder()
    }
    
    @objc func setTextAfterSelected(){
        txt_total.text = dataPicker.selectedValue
        
        //Convert to right format
        let totalCost = Int(txt_total.text!)! * 299000
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        let total = fmt.string(from: NSNumber(value: totalCost))
        
      
        
        lbl_totalTime.text = txt_total.text
        lbl_totalCost.text = total! + " VND"
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        performSegue(withIdentifier: "segue_personalDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_personalDetail" {
            let view = segue.destination as! Step2ViewController
            var order = view.order
            order.date = txt_dateTime.text!
            order.totalTime = lbl_totalTime.text!
            order.totalCost = lbl_totalCost.text!
            order.note = txt_note.text!
        }
    }
    
}
