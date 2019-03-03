//
//  AccountViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/1/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let titles = ["Họ và Tên", "Địa chỉ", "Số điện thoại", "Email"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
