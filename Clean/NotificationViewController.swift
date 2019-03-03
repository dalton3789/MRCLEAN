//
//  NotificationViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/1/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PassData {
    
   

    @IBOutlet weak var tableView: UITableView!
    
    let shareActions = SharedFunctions()
    var messages = [ResponseMMC]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        messages = dataUser.GetRepsonseMessage()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_notification") as! NotificationTableViewCell
        print(messages[indexPath.row].isReplied!)
        
        cell.setData(content: messages[indexPath.row].content!, time: messages[indexPath.row].time!, isMyMessage: (messages[indexPath.row].isReplied! == "1") ? true : false)
        shareActions.setBottomBorder(view: cell)
        return cell
        
        /*
         if indexPath.row != 1{
         cell.setData(content: "This is the message from MR&MRS CLEAN", time: "Today", isMyMessage: false)
         }else {
         cell.setData(content: "The message have been sent by user", time: "Yesterday", isMyMessage: false)
         }
         */
        
    }
    
    
    
    @IBAction func ClearAll(_ sender: UIBarButtonItem) {
        
        dataUser.DeleteAllResponse()
        alertMain.message = "Lịch Sử Tin Nhắn Đã Được Xoá"
        self.present(alertMain, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_sendMessage"{
            let vc = segue.destination as! SendMessageViewController
            vc.passDelegate = self
        }
    }
    
    func passData(data: String) {
        messages = dataUser.GetRepsonseMessage()
        tableView.reloadData()
    }
    
    
}
