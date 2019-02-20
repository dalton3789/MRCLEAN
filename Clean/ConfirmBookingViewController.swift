//
//  ConfirmBookingViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/20/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class ConfirmBookingViewController: UIViewController {

    @IBOutlet weak var lbl_heading1: UILabel!
    
    @IBOutlet weak var lbl_heading2: UILabel!
    
    @IBOutlet weak var lbl_address: UILabel!

    @IBOutlet weak var lbl_dateTime: UILabel!
    
    @IBOutlet weak var lbl_note: UILabel!
    
    
    @IBOutlet weak var lbl_name: UILabel!
    
    
    @IBOutlet weak var lbl_phone: UILabel!

    @IBOutlet weak var lbl_totalCost: UILabel!
    
    
    @IBOutlet weak var lbl_totaltime: UILabel!
    
    
    
    
    let sharedAction = SharedFunctions()
    var order = Order()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        sharedAction.setBottomBorder(view: lbl_heading1)
        sharedAction.setBottomBorder(view: lbl_heading2)
        sharedAction.setBottomBorder(view: lbl_totalCost)
        
        displayBooking()
    }
    
    func displayBooking(){
        lbl_name.text = order.name
        lbl_phone.text = order.phone
        lbl_address.text = order.address
        lbl_note.text = order.note
        lbl_dateTime.text = order.date
        lbl_totaltime.text = order.totalTime + " giờ"
        lbl_totalCost.text = "TỔNG CỘNG : " + order.totalCost
    }


    @IBAction func done(_ sender: UIButton) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }
}
