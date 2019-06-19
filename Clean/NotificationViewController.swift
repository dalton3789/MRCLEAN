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
    var customIndicator = CustomIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        messages = dataUser.GetRepsonseMessage()
        
        customIndicator.mainView = self.view
        customIndicator.addIndicator(view: self, alpha: 1)
        customIndicator.startIndicator()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gatherMessage()
    }
    
    func gatherMessage(){
        let link = Config.destination + "/function/getresponseByToken.php?" + "token=" + CFtoken
        
        let result = server.sendHTTPrequsetWitouthData(link)
        do{
            dataUser.DeleteAllResponse()
            let parsedData = try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []) as? [String:AnyObject]
            
            if let Data = parsedData?["responses"] as? [[String : AnyObject]] {
                
                for event in Data {
                    
                    let content = event["content"] as! String
                    let topic_id = event["topic_id"] as! String
                    let id = event["id"] as! String
                    let customer_id = event["customer_id"] as! String
                    let title = event["title"] as! String
                    let time = event["time"] as! String
                    let isRead = event["isRead"] as! String
                    let isReplied = event["isReplied"] as! String
                    
                    dataUser.AddResponse(id, customer_id, topic_id, content, title, isRead, isReplied, time)
                }
                messages = dataUser.GetRepsonseMessage()
                self.tableView.reloadData()
            }
            customIndicator.stopIndicator()
        }catch{
            shareActions.showErrorToast(message: "Vui lòng thử lại sau!", view: self.view, startY: (self.navigationController?.navigationBar.frame.height)!, endY: (self.navigationController?.navigationBar.frame.height)! + 45)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_notification") as! NotificationTableViewCell
        print(messages[indexPath.row].isReplied!)
        
        cell.setData(content: messages[indexPath.row].content!, time: messages[indexPath.row].time!, isMyMessage: (messages[indexPath.row].isReplied! == "0") ? true : false)
        return cell

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.messageDetail = messages[indexPath.row].content!
        performSegue(withIdentifier: "messageDetail_segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageDetail_segue"{
            PopupDialogHelper.showMessageContentDialog(viewController: self,message: self.messageDetail )
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
    
    @IBAction func createNewMessage(_ sender: UIBarButtonItem) {
        PopupDialogHelper.showMessageContentDialog(viewController : self)
    }
    
    
    func passData(data: String) {
        messages = dataUser.GetRepsonseMessage()
        tableView.reloadData()
    }
    
    
}
