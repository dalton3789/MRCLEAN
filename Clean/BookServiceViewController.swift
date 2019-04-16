//
//  BookServiceViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/25/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class BookServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PassData, InitFunction {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var btn_ok: UIButton!
    
    
    @IBOutlet weak var lbl_total: UILabel!
    
    
    @IBOutlet weak var viewTotal: UIView!
    
  
    let sharedAction = SharedFunctions()
    
    let globalVariables = GlobalValues()
    
    let request = ServiceRequest()
    
    
    let titles = ["ĐỊA ĐIỂM", "NGÀY ĐẶT", "GIỜ ĐẶT", "THÔNG TIN LIÊN HỆ", "GHI CHÚ"]
    
    
    @IBOutlet weak var lbl_titleTotal: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        //let aa = self.view.frame.height
        
        sharedAction.roundBorder(control: btn_ok, width: 1, color: UIColor.white.cgColor, radius: 20)
        sharedAction.roundBorder(control: viewTotal, width: 1, color: UIColor.clear.cgColor, radius: 20)
        sharedAction.setBottomBorder(view: lbl_titleTotal, lineColor : hexStringToUIColor(hex: "331E1A"))
        //sharedAction.view = self.view
        //sharedAction.allignKeyboard()
       
        
    }
    
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return titles.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "location_cell", for: indexPath) as! UserLocationTableViewCell
            
            let locationValue = sharedAction.getSharedData(key:globalVariables.user_address)
            cell.setLocation(location: "Nhấn để chọn địa chỉ")
            if !locationValue.isEmpty{
                cell.setLocation(location: locationValue)
                request.address = locationValue
            }
            
            
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "date_cell", for: indexPath) as! DateTableViewCell
            
            let dateValue = sharedAction.getSharedData(key: globalVariables.booking_date)
            cell.setDate(date: "Nhấn để chọn ngày giờ")
            if !dateValue.isEmpty{
                cell.setDate(date: dateValue)
                request.date = dateValue
                
            }
        
            
            return cell
            
            
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "time_cell", for: indexPath) as! BookingTimeTableViewCell
            cell.delegate = self
            return cell
        }
        
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "people_cell", for: indexPath) as! PersonInfoTableViewCell
            let globalValues = GlobalValues()
            let userName = sharedAction.getSharedData(key: globalValues.user_name)
           let userPhone = sharedAction.getSharedData(key: globalValues.user_phone)
            if !userName.isEmpty {
               cell.setPersonalInfo(info: userName + " - " + userPhone)
                request.name = userName
                request.phone = userPhone
            }
            
            return cell
        }
        
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "note_cell", for: indexPath)
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (indexPath.section < 4) ? (self.view.frame.height)/16 : 100
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "segue_location", sender: self)
       
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = hexStringToUIColor(hex: "9B8F8E")
        
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width, height: view.frame.height))
        label.text = titles[section]
        label.textColor = UIColor.black
        
        view.addSubview(label)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissInteraction)))
        return view
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func passData(data: String) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_people" {
            let vc  = segue.destination as! PersonalViewController
            vc.delegate = self
        }
        if segue.identifier == "segue_confirmbooking" {
            let vc = segue.destination as! ConfirmBookingViewController
            vc.order = request
        }
        if segue.identifier == "segue_bookdate"{
            let vc = segue.destination as! CalendarViewController
            vc.passdateDelegate = self
        }
        if segue.identifier == "segue_location" {
            let vc  = segue.destination as! LocationViewController
            vc.passDelegate = self
        }
    }
    
    func dismissInteraction() {
        tableView.endEditing(true)
    }

    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
    
    
    @IBAction func done(_ sender: UIButton) {
        let totalTime  = sharedAction.getSharedData(key: globalVariables.booking_time)
        let totalWorker = sharedAction.getSharedData(key: globalVariables.booking_totalWorker)
        let note = sharedAction.getSharedData(key: globalVariables.booking_note)
        request.total = self.lbl_total.text!
        
        if totalTime.isEmpty || totalWorker.isEmpty || request.address.isEmpty || request.date.isEmpty || request.name.isEmpty || request.total.isEmpty{
            //showAlert(view: self, title: "Lỗi", alert: "Vui lòng nhập đầy đủ thông tin")
            
            sharedAction.showErrorToast(message: "Vui lòng nhập đầy đủ thông tin", view: self.view, startY: (self.navigationController?.navigationBar.frame.height)!, endY: (self.navigationController?.navigationBar.frame.height)! + 45)
        }else {
            request.totalTime = totalTime
            request.totalWorker = totalWorker
            request.note = note
            
            
            let request_content = ["email": "", "name": request.name, "phone": request.phone, "address" : request.address, "bdate": "", "startTime": request.date, "endTime" : request.totalTime, "note" : request.note, " " : request.totalTime, "total" : request.total] as [String: Any]
             let link = Config.destination + "/function/createRequestBook.php"
             
             server.sendHTTPrequsetWithData(request_content, link)
            
            
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_date)
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_note)
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_time)
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_totalWorker)
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_totalCost)
            performSegue(withIdentifier: "segue_confirmbooking", sender: self)
        }
        
        
    }
    
    func InitFunction() {
        let total = sharedAction.getSharedData(key: globalVariables.booking_totalCost)
        if !total.isEmpty {
            lbl_total.text = total + " VND"
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_totalCost)
        }
    }
    
    
   
}

