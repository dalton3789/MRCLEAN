//
//  MessageDetailViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/6/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    
    @IBOutlet weak var btn_reply: UIButton!
    
    
    @IBOutlet weak var btn_close: UIButton!
    
    
    let shareAction = SharedFunctions()
    
    
    @IBOutlet weak var txt_messageDetail: UITextView!
    
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shareAction.roundBorder(control: btn_close, width: 1.0, color: hexStringToUIColor(hex: "331E1A").cgColor, radius: 15)
        shareAction.roundBorder(control: btn_reply, width: 1.0, color: UIColor.clear.cgColor, radius: 15)
        txt_messageDetail.text = message
    }
    

    @IBAction func btn_close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    
    
    @IBAction func reply(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: {})
    }
    

}
