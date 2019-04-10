//
//  HomeBookingViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 4/7/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class HomeBookingViewController: UIViewController {

    
    @IBOutlet weak var view_hour: UIView!
    
    
    @IBOutlet weak var view_post: UIView!
    
    
    @IBOutlet weak var view_deep: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view_hour.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHour)))
        view_deep.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectDeep)))
        view_post.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPost)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "ĐẶT DỊCH VỤ"
    }
    

    @objc func selectHour(){
        performSegue(withIdentifier: "hour_services", sender: self)
    }
    @objc func selectDeep(){
        performSegue(withIdentifier: "deep_service", sender: self)
    }
    @objc func selectPost(){
        performSegue(withIdentifier: "post_service", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "post_service" {
            let vc = segue.destination as! DeepPostServiceViewController
            vc.tittle = "DỊCH VỤ SAU XÂY DỰNG"
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
