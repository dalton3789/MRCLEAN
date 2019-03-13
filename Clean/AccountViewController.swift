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
    let cIndicator = CustomIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cIndicator.addIndicator(view: self, alpha: 1)
        cIndicator.startIndicator()

        user = dataUser.GetUser().first!
        
        let link3 = Config.destination + "/function/login_ios.php?email=" + user.email! + "&password=" + user.code!
        let result = server.sendHTTPrequsetWitouthData(link3)
        
        getUserDataJSON(result: result)
        
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
        cIndicator.startIndicator()
        
        user = dataUser.GetUser().first!
        
        let link3 = Config.destination + "/function/login_ios.php?email=" + user.email! + "&password=" + user.code!
        let result = server.sendHTTPrequsetWitouthData(link3)
        
        getUserDataJSON(result: result)
        self.data = [["Họ và Tên " , "Địa chỉ", "Số điện thoại","Email"] ,[ user.name!, user.address!,  user.phone!,  user.email!] ]
        tableView.reloadData()
    }
    
    
    func getUserDataJSON(result : String){
        do{
            let parsedData = try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []) as? [String:AnyObject]
            
            if let Data = parsedData?["customers"] as? [[String : AnyObject]] {
                dataUser.DeleteAllUser()
                for event in Data {
                    
                    let name = event["name"] as! String
                    let address = event["address"] as! String
                    let id = event["id"] as! String
                    let password = event["password"] as! String
                    let phone = event["phone"] as! String
                    let email = event["email"] as! String
                    
                    
                    dataUser.AddUser(name, address, id, true, false, "", password, phone, email, CFtoken)
                }
                
                self.user = dataUser.GetUser().first!
                self.tableView.reloadData()
                self.cIndicator.stopIndicator()
                
            }
        } catch{
            print(error)
        }
    }
    
}
