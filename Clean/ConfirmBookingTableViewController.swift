//
//  ConfirmBookingTableViewController.swift
//  Clean
//
//  Created by Toan Nguyen on 6/13/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class ConfirmBookingTableViewController: UITableViewController {

    let cIndicator = CustomIndicator()
    let sharedAction = SharedFunctions()
    var order =  ServiceRequest()
    let header = ["THÔNG TIN ĐƠN HÀNG","THÔNG TIN KHÁCH HÀNG"]
    var data = [Data]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data.append(Data(icon: UIImage(), desciption: "THÔNG TIN ĐƠN HÀNG"))
        data.append(Data(icon: UIImage(named: "date_icon")!, desciption: "Ngày làm việc : \(order.date)"))
        data.append(Data(icon: UIImage(named: "service_icon")!, desciption: "Loại dịch vụ : \(order.type)"))
        data.append(Data(icon: UIImage(named: "meter_icon")!, desciption: "Diện tích : \(order.area)"))
        data.append(Data(icon: UIImage(named: "pin_icon")!, desciption: "Ghi chú : \(order.note)"))
        //data.append(Data(icon: UIImage(), desciption: ""))
        data.append(Data(icon: UIImage(), desciption: "THÔNG TIN KHÁCH HÀNG"))
        data.append(Data(icon: UIImage(named: "account")!, desciption: "Họ và Tên : \(order.name)"))
        data.append(Data(icon: UIImage(named: "phone_icon")!, desciption: "Số điện thoại : \(order.phone)"))
        data.append(Data(icon: UIImage(named: "address_icon")!, desciption: "Địa chỉ : \(order.address)"))
        //data.append(Data(icon: UIImage(), desciption: ""))
        
        tableView.reload(animationDirection: .down)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let orderAction = Order()
        orderAction.AddBooking(order.name, order.address, "", order.phone, order.date, order.totalTime, order.total, order.note, "")
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "XÁC NHẬN DỊCH VỤ"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return data.count
        default:
            return 1
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "basic_cell") as! ConfirmBookingableViewCell
            
            cell.setData(image: data[indexPath.row].icon, description: data[indexPath.row].desciption)
            
            return cell
        case 1 :
            let cell = UITableViewCell()
            cell.textLabel?.text = "* Lưu ý : Nhân viên của chúng tôi sẽ liên hệ với quý khách để xác nhận đơn hàng. Xin cảm ơn"
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "confirm_cell") as! ConfirmButtonTableViewCell
            cell.controller = self.navigationController
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 120
        case 2:
            return 80
        default:
            return 40
        }
    }

    struct Data {
        var icon : UIImage
        var desciption : String
    }
    
    
}
