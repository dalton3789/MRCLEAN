//
//  BasicServiceViewController.swift
//  Clean
//
//  Created by James on 7/10/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class BasicServiceViewController: UIViewController {

    
    @IBOutlet weak var btn_order: UIButton!
    
    @IBOutlet weak var btn_home: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        btn_order.layer.cornerRadius = 30
        btn_order.layer.borderWidth = 1
        btn_home.layer.backgroundColor = hexStringToUIColor(hex: "959595").cgColor
        btn_home.layer.cornerRadius = 30
        btn_home.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
