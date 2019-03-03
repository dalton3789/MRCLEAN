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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookings = Order().GetBookings()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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

        cell.setData(detail: bookings[indexPath.row].name!, date: bookings[indexPath.row].date!)
        shareAction.setBottomBorder(view: cell)

        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return self.view.frame.height / 12
    }
}
