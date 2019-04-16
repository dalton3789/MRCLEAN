//
//  BookingTimeTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/26/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class BookingTimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txt_time: UITextField!
    
    
    @IBOutlet weak var txt_totalWorker: UITextField!
    
    let dataPicker = PickerDifinition()
    var picker = UIPickerView()
    let globalValues = GlobalValues()
    
    var numHour = ""
    var numWorker = ""
    var currentPrice = 0
    
    var delegate : InitFunction?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let link = Config.destination + "/function/priceonlineservice.php"
        let result = server.sendHTTPrequsetWitouthData(link)
        self.currentPrice = Int(result)!
        
        // Initialization code
        dataPicker.values = ["" ,"2", "3" , "4" , "5" ,"6" ,"7" ,"8"]
        dataPicker.selectAction = setTextAfterSelected
        picker.delegate = dataPicker
        picker.dataSource = dataPicker
        
        let timeViewPicker = UIPickerView()
        timeViewPicker.delegate = dataPicker
        timeViewPicker.dataSource = dataPicker
        txt_time.inputView = timeViewPicker
        txt_totalWorker.inputView = picker
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func dismissKeyboard(){
        txt_time.resignFirstResponder()
        txt_totalWorker.resignFirstResponder()
    }
 
    @objc func setTextAfterSelected(){
        let globalValue = GlobalValues()
        if txt_totalWorker.isEditing {
            txt_totalWorker.text = dataPicker.selectedValue
            numWorker = dataPicker.selectedValue
            UserDefaults.standard.set(dataPicker.selectedValue, forKey: globalValue.booking_totalWorker)
            
        }else {
            txt_time.text = dataPicker.selectedValue
            numHour = dataPicker.selectedValue
            UserDefaults.standard.set(dataPicker.selectedValue, forKey: globalValue.booking_time)
            
        }
        
        if !numHour.isEmpty && !numWorker.isEmpty {
            let totalCost = Int(numHour)! * self.currentPrice * Int(numWorker)!
            let fmt = NumberFormatter()
            fmt.numberStyle = .decimal
            let total = fmt.string(from: NSNumber(value: totalCost))
            UserDefaults.standard.set(total, forKey: globalValue.booking_totalCost)
        }
        
        if let delegate = self.delegate {
            delegate.InitFunction()
        }
        self.endEditing(true)
    }

}
