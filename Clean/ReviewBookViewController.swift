//
//  ReviewBookViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/21/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class ReviewBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let aa = Order()
        let bb = aa.GetBookings()
        print(bb)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
