//
//  MessageContentViewController.swift
//  Clean
//
//  Created by Dalton Nguyen on 6/19/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class MessageContentViewController: UIViewController {

    @IBOutlet weak var txt_description: UITextView!
    var descripttionText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_description.text = descripttionText
    }
    
    func displayReplyMesage(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SendMessageViewController")
        navigationController?.present(vc, animated: true, completion: nil)
        
    }
}
