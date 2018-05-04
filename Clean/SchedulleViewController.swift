//
//  SchedulleViewController.swift
//  Clean
//
//  Created by James on 7/8/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class SchedulleViewController: UIViewController {


    @IBOutlet weak var img_gif: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_duration: UILabel!
    @IBOutlet weak var lbl_schedule: UILabel!
    
    @IBOutlet weak var subview: UIView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.startAnimating()
        getCustomerContractInfo()
        img_gif.loadGif(name: "profile")
        //Update Token To Server if needed
        checkTokenValidity()
        
        
        

        // Do any additional setup after loading the view.
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
    
    private func getCustomerContractInfo(){
        
        DispatchQueue.global(qos: .background).async {
            let id =  dataUser.GetUser().first?.id!
            let link = Config.destination + "/function/getCustomerContractInfo.php?id=" + id!
            
            
            let result =  server.sendHTTPrequsetWitouthData(link)
            
            
            DispatchQueue.main.sync {
                
                do {
                    if (result == ""){
                        let alert = UIAlertController(title: "", message: "Lỗi Kết Nối Hệ Thống, Vui lòng Kiểm Tra Kết Nối Mạng hoặc Truy Cập Sau. Xin Cảm Ơn!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { action in
                            //run your function here
                            self.GoHomeView()
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }

                    
                    let parsedData = try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []) as? [String:AnyObject]
                    
                    if let Data = parsedData?["contract"] as? [[String : AnyObject]] {
                        
                        for event in Data {
                            self.lbl_name.text = (event["name"] as! String)
                            self.lbl_address.text = (event["address"] as! String)
                            self.lbl_duration.text = (event["startDate"] as! String) + " tới ngày " + (event["endDate"] as! String)
                            self.lbl_schedule.text = (event["schedule"] as! String)
                            self.lbl_schedule.textAlignment = .natural
                            
                        }
                        self.activity.stopAnimating()
                        self.subview.isHidden = true
                    }
                    
                    
                    
                }
                catch {
                    print(error)
                }
                
                
            }
            
        }
        
    }
    
    func GoHomeView(){
        
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)

    }
    
    
    private func checkTokenValidity(){
        
        DispatchQueue.global(qos: .background).async {
            let id =  dataUser.GetUser().first?.id!
            let link = Config.destination + "/function/getcustomerbyid.php?id=" + id!
            var tokenServer = ""
            
            let result =  server.sendHTTPrequsetWitouthData(link)
            
            
            DispatchQueue.main.sync {
                
                do {
                    if (result == ""){
                        let alert = UIAlertController(title: "", message: "Lỗi Kết Nối Hệ Thống, Vui lòng Kiểm Tra Kết Nối Mạng hoặc Truy Cập Sau. Xin Cảm Ơn!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil ))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    let parsedData = try JSONSerialization.jsonObject(with: result.data(using: .utf8)!, options: []) as? [String:AnyObject]
                    
                    if let Data = parsedData?["customers"] as? [[String : AnyObject]] {
                        
                        for event in Data {
                            tokenServer =  (event["token"] as! String)
                            
                        }
                    }
                    
                    
                 
                    //Update token if it's null
                    if (tokenServer.isEmpty){
                        let requestConent = ["id" : id!, "token" : CFtoken ] as [String : Any]
                        let link = Config.destination + "/function/updatetoken.php"
                        
                        server.sendHTTPrequsetWithData(requestConent, link)
                    }
                }
                catch {
                    print(error)
                }
                
                
            }
            
        }
        
    }
    

    
    
}
