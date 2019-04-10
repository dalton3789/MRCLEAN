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
    
    
    
    let cIndicator = CustomIndicator()
    let sharedAction = SharedFunctions()
    var order =  ServiceRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        sharedAction.setBottomBorder(view: lbl_heading1)
        sharedAction.setBottomBorder(view: lbl_heading2)
        sharedAction.setBottomBorder(view: lbl_totalCost)
        
        cIndicator.addIndicator(view: self, alpha: 1)
        //cIndicator.startIndicator()
        //sleep(1)
       // getBookingData()
        displayBooking()
        let orderAction = Order()
        orderAction.AddBooking(order.name, order.address, "", order.phone, order.date, order.totalTime, order.total, order.note, "")
        
    }
    
    func getBookingData(){
        let link = Config.destination + "/function/getlatestrequestorder.php?name=" + order.name + "&phone=" + order.phone
        
        let result = server.sendHTTPrequsetWitouthData(link)
        
        do{
            let parsedData = try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []) as? [String:AnyObject]
            
            if let Data = parsedData?["response"] as? [[String : AnyObject]] {
                let orderAction = Order()
                for event in Data {
                    
                    let name = event["name"] as! String
                    let address = event["address"] as! String
                    let id = event["id"] as! String
                    
                    
                    orderAction.AddBooking(name, address, id, order.phone, order.date, order.totalTime, order.total, order.note, "")
                }
                
                
                displayBooking()
                self.cIndicator.stopIndicator()
            }
        } catch{
            print(error)
        }
    }
    
    func displayBooking(){
        lbl_name.text = order.name
        lbl_phone.text = order.phone
        lbl_address.text = order.address
        lbl_note.text = order.note
        lbl_dateTime.text = order.date
        lbl_totaltime.text = order.totalTime + " giờ"
        lbl_totalCost.text = "TỔNG CỘNG : " + order.total
        
       
    }


    @IBAction func done(_ sender: UIButton) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }
}
