//
//  AccountViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/1/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, PassData {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [[String]]()
    
    let titles = ["Họ và Tên", "Địa chỉ", "Số điện thoại", "Email"]
    var icons = [UIImage]()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = dataUser.GetUser().first!
        data = [["Họ và Tên " , "Địa chỉ", "Số điện thoại","Email"] ,[ user.name!, user.address!,  user.phone!,  user.email!] ]

        tableView.delegate = self
        tableView.dataSource = self
        
        icons = [UIImage(named: "person_icon"), UIImage(named: "address"), UIImage(named: "phone"), UIImage(named: "mail")] as! [UIImage]
        
        tableView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? 0.1 : 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "header_account")!
        }
        else if indexPath.section == 1 {
            let cellInfo = tableView.dequeueReusableCell(withIdentifier: "personalInfo_cell") as! AccountTableViewCell
            cellInfo.setData(img: icons[indexPath.row], info: data[1][indexPath.row])
            
            return cellInfo
        }
        
        
        return cell
    }
    
    
    @IBAction func editInfo(_ sender: UIButton) {
        performSegue(withIdentifier: "updateAccount_segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateAccount_segue" {
            let vc = segue.destination as! UpdateAccountViewController
            vc.user = self.user
            vc.dataDelegate = self
        }
    }
    
    func passData(data: String) {
        user = dataUser.GetUser().first!
        self.data = [["Họ và Tên " , "Địa chỉ", "Số điện thoại","Email"] ,[ user.name!, user.address!,  user.phone!,  user.email!] ]
        tableView.reloadData()
    }
    
}
