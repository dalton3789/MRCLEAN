//
//  ReviewBookingViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/4/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class ReviewBookingViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var lbl_totalTime: UILabel!
    
    @IBOutlet weak var lbl_note: UILabel!
    
    
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var lbl_phone: UILabel!
    
    
    @IBOutlet weak var lbl_address: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    
    @IBOutlet weak var star2: UIImageView!
    
    @IBOutlet weak var star3: UIImageView!
    
    @IBOutlet weak var star4: UIImageView!
    
    
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var lbl_title1: UILabel!
    
    @IBOutlet weak var lbl_title2: UILabel!
    
    @IBOutlet weak var lbl_title3: UILabel!
    
    
    @IBOutlet weak var txt_note: UITextView!
    
    var booking = Booking()
    let shareActions = SharedFunctions()
    var isVoted = false
    var numofStar = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        star1.isUserInteractionEnabled = true
        star2.isUserInteractionEnabled = true
        star3.isUserInteractionEnabled = true
        star4.isUserInteractionEnabled = true
        star5.isUserInteractionEnabled = true
        
        star1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.vote(_: ))))
        star2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.vote(_: ))))
        star3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.vote(_: ))))
        star4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.vote(_: ))))
        star5.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.vote(_: ))))
        
        shareActions.setBottomBorder(view: lbl_title1)
        shareActions.setBottomBorder(view: lbl_title2)
        shareActions.setBottomBorder(view: lbl_title3)
        
        txt_note.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
        setData(data: booking)
        
        shareActions.view = self.view
        shareActions.allignKeyboard()
        
    }
    
    func setData(data : Booking){
        lbl_date.text = data.date!
        lbl_name.text = data.name!
        lbl_note.text = data.note!
        lbl_phone.text = data.phone!
        lbl_address.text = data.address!
        lbl_totalTime.text = data.totalTime!
        
        if !(data.review?.isEmpty)!{
            
            let review = data.review?.components(separatedBy: "|")
            txt_note.text = review![1]
            setStar(num: Int(review![0])!)
            self.view.isUserInteractionEnabled = false
            shareActions.showErrorToast(message: "Đơn hàng này đã được đánh giá", view: self.view, startY: (self.navigationController?.navigationBar.frame.height)!, endY: (self.navigationController?.navigationBar.frame.height)! + 45)
            
        }
       
    }
    
     @objc func dismissKeyboard(){
        txt_note.resignFirstResponder()
    }
    
    @objc func vote( _ sender : Any){
      
        let gesture = sender as! UIGestureRecognizer
        //let contr
        self.numofStar = (gesture.view?.tag)!
        setStar(num: self.numofStar)
        self.isVoted = true
    }
    
    func setStar(num : Int){
        let controls = [star1,star2,star3,star4,star5]
        resetStar()
        for i in 0...num - 1 {
            controls[i]?.image = UIImage(named: "selected_star")
        }
    }
    
    func resetStar(){
        let controls = [star1,star2,star3,star4,star5]
        
        for star in controls {
            star?.image = UIImage(named: "unselected_star")
        }
    }
    
    
    
    @IBAction func reviewBooking(_ sender: UIButton) {
        if !self.isVoted{
            shareActions.showErrorToast(message: "Vui lòng chọn số sao tương ứng", view: self.view,startY: 50, endY: 90)
        } else {
            booking.review = String(self.numofStar) + "|" + txt_note.text
            Order().UpdateBooking(booking)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text! == "Ghi chú" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
    }
    
    
   

}
