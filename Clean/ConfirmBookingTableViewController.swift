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
        data.append(Data(icon: UIImage(named: "time_icon")!, desciption: "Tổng thời gian : \(order.totalTime)"))
        data.append(Data(icon: UIImage(named: "pin_icon")!, desciption: "Ghi chú : \(order.note)"))
        data.append(Data(icon: UIImage(), desciption: ""))
        data.append(Data(icon: UIImage(), desciption: "THÔNG TIN KHÁCH HÀNG"))
        data.append(Data(icon: UIImage(named: "date_icon")!, desciption: "Họ và Tên : \(order.name)"))
        data.append(Data(icon: UIImage(named: "date_icon")!, desciption: "Só điện thoại : \(order.phone)"))
        data.append(Data(icon: UIImage(named: "date_icon")!, desciption: "Địa chỉ : \(order.address)"))
        data.append(Data(icon: UIImage(), desciption: ""))
        data.append(Data(icon: UIImage(), desciption: "* Lưu ý : Nhân viên của chúng tôi sẽ liên hệ với quý khách để xác nhận đơn hàng. Xin cảm ơn"))

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic_cell") as! ConfirmBookingableViewCell
        
        cell.setData(image: data[indexPath.row].icon, description: data[indexPath.row].desciption)
        
        return cell
    }

    struct Data {
        var icon : UIImage
        var desciption : String
    }
}
