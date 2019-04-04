//
//  CustomerBookingTableViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/3/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class CustomerBookingTableViewController: UITableViewController {

    var bookings = [Booking]()
    let shareAction = SharedFunctions()
    var order = Booking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookings = Order().GetBookings()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customerBooking_cell", for: indexPath) as! CustomerBookingTableViewCell

        cell.setData(detail: "Ngày đặt dịch vụ : " + bookings[indexPath.row].date! , date: bookings[indexPath.row].name!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        order = bookings[indexPath.row]
        performSegue(withIdentifier: "reviewBooking_segue", sender: self)
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return self.view.frame.height / 8
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewBooking_segue"{
            let vc = segue.destination as! ReviewBookingViewController
            vc.booking = order
        }
    }
}
