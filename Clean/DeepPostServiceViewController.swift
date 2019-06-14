//
//  DeepPostServiceViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 4/7/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class DeepPostServiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PassData {


    var tittle = "CHUYÊN SÂU"
    let titles = ["ĐỊA ĐIỂM", "NGÀY ĐẶT", "DIỆN TÍCH", "THÔNG TIN LIÊN HỆ", "GHI CHÚ"]
    var area = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btn_done: UIButton!
    
    @IBOutlet weak var lbl_note: UILabel!
    
    
    
    
    let sharedAction = SharedFunctions()
    
    let globalVariables = GlobalValues()
    
    let request = ServiceRequest()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = tittle
        tableView.dataSource = self
        tableView.delegate = self
        
        
        sharedAction.roundBorder(control: btn_done, width: 1, color: UIColor.white.cgColor, radius: 20)
        sharedAction.setBottomBorder(view: lbl_note, lineColor : hexStringToUIColor(hex: "331E1A"))
        tableView.reload(animationDirection: .right)
    }
    
    @objc func dismisKeyboard(){
        tableView.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = title
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "time_cell", for: indexPath) as! AreaTableViewCell
            
            //cell.delegate = self
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = hexStringToUIColor(hex: "9B8F8E")
        
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width, height: view.frame.height))
        label.text = titles[section]
        label.textColor = UIColor.black
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismisKeyboard)))
        
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (indexPath.section < 4) ? (self.view.frame.height)/16 : 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "deep_post_name" {
            let vc  = segue.destination as! PersonalViewController
            vc.delegate = self
        }
        if segue.identifier == "deep_post_confirm" {
            let vc = segue.destination as! ConfirmBookingTableViewController
            vc.order = request
        }
        if segue.identifier == "deep_post_time"{
            let vc = segue.destination as! CalendarViewController
            vc.passdateDelegate = self
        }
        if segue.identifier == "deep_post_location" {
            let vc  = segue.destination as! LocationViewController
            vc.passDelegate = self
        }
        
    }
    
    func passData(data: String) {
        tableView.reloadData()
    }
    
    
    
    @IBAction func confirm(_ sender: UIButton) {
        let areaCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! AreaTableViewCell
        request.area = areaCell.getValue()
        
        if request.address.isEmpty || request.name.isEmpty || request.date.isEmpty || request.area.isEmpty {
            sharedAction.showErrorToast(message: "Vui lòng nhập đầy đủ thông tin", view: self.view, startY: (self.navigationController?.navigationBar.frame.height)!, endY: (self.navigationController?.navigationBar.frame.height)! + 45)
        } else {
            request.note = sharedAction.getSharedData(key: globalVariables.booking_note)
            request.type = self.tittle
            
            let request_content = ["email": "", "name": request.name, "phone": request.phone, "address" : request.address, "bdate": "", "startTime": request.date, "endTime" : request.totalTime, "note" : request.note + " - Diện tích : " + request.area + " - Loại : " + tittle, "total" : request.total] as [String: Any]
            let link = Config.destination + "/function/createRequestBook.php"
            
            //server.sendHTTPrequsetWithData(request_content, link)
            
            
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_date)
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_note)
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_time)
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_totalWorker)
            UserDefaults.standard.removeObject(forKey: globalVariables.booking_totalCost)
            
            performSegue(withIdentifier: "deep_post_confirm", sender: self)

        }
        
    }
    
    

}
