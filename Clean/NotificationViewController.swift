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
    var messageDetail = ""
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.messageDetail = messages[indexPath.row].content!
        performSegue(withIdentifier: "messageDetail_segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageDetail_segue"{
            let vc = segue.destination as! MessageDetailViewController
            vc.message = self.messageDetail
        }
        if segue.identifier == "segue_sendMessage"{
            let vc = segue.destination as! SendMessageViewController
            vc.passDelegate = self
        }
    }
    
    @IBAction func ClearAll(_ sender: UIBarButtonItem) {
        
        shareActions.showConfirmAlert(view: self, title: "Xoá lịch sử", alert: "Xoá tất cả thông báo?", confirmAction: self.deleteAllChats)
        
    }
    
    func deleteAllChats(){
        dataUser.DeleteAllResponse()
        messages = dataUser.GetRepsonseMessage()
        tableView.reloadData()
    }
    
    
  
    
    func passData(data: String) {
        messages = dataUser.GetRepsonseMessage()
        tableView.reloadData()
    }
    
    
}
