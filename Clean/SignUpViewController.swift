//
//  SignUpViewController.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/1/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit
import MapKit

class SignUpViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_name: UITextField!
    
    @IBOutlet weak var txt_phone: UITextField!
    
    @IBOutlet weak var txt_address: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    @IBOutlet weak var btn_signup: UIButton!
    
    
    @IBOutlet weak var img_back: UIImageView!
    
    let shareAction = SharedFunctions()
    var activityIndicator = CustomIndicator()
    
    let managerDelegate = CLLocationManager()
    var defaultLocation = CLLocation()
    var location = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shareAction.roundBorder(control: btn_signup, width: 1, color: UIColor.clear.cgColor, radius: 15)
        shareAction.setBottomBorder(view: txt_email)
        shareAction.setBottomBorder(view: txt_phone)
        shareAction.setBottomBorder(view: txt_name)
        shareAction.setBottomBorder(view: txt_address)
        shareAction.setBottomBorder(view: txt_password)
        
        managerDelegate.delegate = self
        managerDelegate.desiredAccuracy = kCLLocationAccuracyBest
        managerDelegate.requestWhenInUseAuthorization()
        managerDelegate.startUpdatingLocation()
        
        img_back.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( self.cancel)))
        img_back.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector( self.cancelKeyboard)))
       
        
    }
    
    
    @objc func cancel(){
       // performSegue(withIdentifier: "segue_backtologin", sender: self)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userLocation_segue" {
            let vc = segue.destination as! LocationViewController
            
            
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: vc.view.frame.width, height: 44))
            
            
            let navItem = UINavigationItem(title: "Địa Chỉ")
            let doneItem =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(cancelLocationView))
            
           
            navItem.leftBarButtonItem = doneItem
            
            navBar.setItems([navItem], animated: false)
            
            vc.view.addSubview(navBar);
        }
    }
    
    @objc func cancelLocationView(){
        print("A")
    }
    
    @objc func cancelKeyboard(){
        txt_phone.resignFirstResponder()
        txt_email.resignFirstResponder()
        txt_name.resignFirstResponder()
        txt_address.resignFirstResponder()
        txt_password.resignFirstResponder()
    }

    func validAllTextBox() -> (Bool,String) {
        let email = txt_email.text!
        let phone = txt_phone.text!
        var result = false
        if !email.isEmpty {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            result = emailPredicate.evaluate(with: email)
            if !result {
                return (result, "Địa chỉ email không chính xác")
            }
        }else if email.isEmpty{
             return (false, "Vui lòng nhập địa chỉ email")
        }
        if !phone.isEmpty {
            do {
                let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
                let matches = detector.matches(in: phone, options: [], range: NSMakeRange(0, phone.count))
                if let res = matches.first {
                    result = res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == phone.count
                } else {
                    return (false, "Số điện thoại chưa đúng")
                }
            } catch {
                return (false, "Số điện thoại chưa đúng")
            }
        }else if phone.isEmpty{
            return(false,"Vui lòng nhập số điện thoại")
        }
        if (txt_address.text?.isEmpty)!{
            return(false, "Vui lòng nhập địa chỉ")
        }
        if (txt_password.text?.isEmpty)!{
            return(false, "Vui lòng nhập password")
        }
        if (txt_name.text?.isEmpty)!{
            return(false, "Vui lòng nhập họ và tên")
        }
        return(true, "")
    }
    
   
    
   
    @IBAction func register(_ sender: UIButton) {
        
        
        let result = validAllTextBox()
        
        if !result.0{
            //showAlert(view: self, title: "Lỗi", alert: result.1)
            shareAction.showErrorToast(message: result.1, view: self.view)
        }else {
            
            let link = Config.destination + "/function/checkemailexist.php?email=" + txt_email.text!
            
            let result = server.sendHTTPrequsetWitouthData(link)
            
            if result.contains("Yes"){
                shareAction.showErrorToast(message: "Địa chỉ email đã được đăng kí", view: view, startY: 40, endY: 95)
            } else{
                
                let request_content = ["email": txt_email.text!, "name": txt_name.text!, "isBlock": "0", "role" : "customer", "cpassword": txt_password.text!, "token" : CFtoken, "cusername" : "thisisaniosaccount", "address" : txt_address.text!, "phone" : txt_phone.text!] as [String: Any]
                let link2 = Config.destination + "/function/createuser.php"
                server.sendHTTPrequsetWithData(request_content, link2)
                
                dataUser.DeleteAllUser()
                dataUser.AddUser(txt_name.text!, txt_address.text!, "1", true, false, "", txt_password.text!, txt_phone.text!, txt_email.text!, CFtoken)
              
                
                
                
                
                performSegue(withIdentifier: "home_segue", sender: self)
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        activityIndicator.addIndicator(view: self, alpha: 1.0)
        activityIndicator.startIndicator()
        
        defaultLocation = locations[0]
     
        getAdressName(coords: defaultLocation)
        
        activityIndicator.stopIndicator()
        
        
    }
    
    func getAdressName(coords: CLLocation) {
        let geo = CLGeocoder()
        var address = ""
        
        geo.reverseGeocodeLocation(coords, completionHandler: {(placemark, error) -> Void in
            if error != nil {
                print("Failed")
                return
            }
            if ((placemark?.count)!) > 0 {
                let pm = placemark?[0] as! CLPlacemark!
                
                if pm?.subThoroughfare != nil {
                    address += (pm?.subThoroughfare)! + " "
                }
                if pm?.thoroughfare != nil {
                    address += (pm?.thoroughfare)! + " , "
                }
                if pm?.subLocality != nil {
                    address += (pm?.subLocality)! + " , "
                }
                
                if pm?.subAdministrativeArea != nil {
                    address += (pm?.subAdministrativeArea)! + " , "
                }
                if pm?.administrativeArea != nil {
                    address += (pm?.administrativeArea)!
                }
                
                self.location = address
                self.txt_address.text = address
                
            }
        })
    }
    
    

}
