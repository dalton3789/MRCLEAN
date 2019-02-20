//
//  ReviewRequestViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 5/6/18.
//  Copyright © 2018 James. All rights reserved.
//

import UIKit

class ReviewRequestViewController: UIViewController {
    
    var request = ServiceRequest()

    @IBOutlet weak var lbl_name: UILabel!
    
    
    @IBOutlet weak var lbl_address: UITextView!
    
    @IBOutlet weak var lbl_phone: UILabel!
    
    
    @IBOutlet weak var lbl_email: UILabel!
    
    
    @IBOutlet weak var lbl_dateTime: UITextView!
    
    @IBOutlet weak var lbl_note: UITextView!
    
    @IBOutlet weak var lbl_total: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbl_name.text = request.name
        lbl_address.text = request.address
        lbl_phone.text = request.phone
        lbl_email.text = request.email
        lbl_dateTime.text = "Ngày làm việc : " + request.date + "\n" + "Giờ làm : " + request.startTime + " - " + request.endTime
        lbl_note.text = request.note
        lbl_total.text = request.total
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func confirmRequest(_ sender: UIButton) {
        
        let request_content = ["email": request.email, "name": request.name, "phone":request.phone, "address" : request.address, "date":request.date, "startTime": request.startTime, "note" : request.note, "endTime" : request.endTime, "total" : request.total] as [String: Any]
        let link = Config.destination + "/function/createRequestBook.php"
        
        server.sendHTTPrequsetWithData(request_content, link)
        
        
        
        let alert = UIAlertController(title: "", message: "Đơn hàng đã được gửi thành công. Nhân Viên Của Chúng Tôi Sẽ Liên Lạc Để Hỗ Trợ Yêu Cầu Dịch Vụ Của Quý Khách", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:
            { action in
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                
                self.present(newViewController, animated: true, completion: nil)
        }
        ))
        //alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")}))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    

}
