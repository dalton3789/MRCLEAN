//
//  SharedFunctions.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/20/19.
//  Copyright © 2019 James. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseMessaging

public class SharedFunctions {
    
    var view : UIView?

    public func setBottomBorder(view : UIView) {
        //view.borderStyle = .none
        view.layer.backgroundColor = UIColor.white.cgColor
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 0.0
    }
    
    public func setBottomBorder(view : UIView, lineColor : UIColor) {
        //view.borderStyle = .none
        view.layer.backgroundColor = UIColor.white.cgColor
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = lineColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 0.0
    }
    
   
    func roundBorder(control : UIView, width : CGFloat, color : CGColor, radius : CGFloat ){
        control.layer.borderWidth = width
        control.layer.borderColor = color
        control.layer.cornerRadius = radius
    }
    
    func getSharedData(key : String) -> String {
        
        if let value = UserDefaults.standard.string(forKey: key ){
            return value
        }
        return ""
    }
    
    func setTransparentNavigation(view : UIViewController){
        view.navigationController?.navigationBar.isTranslucent = true
        view.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        view.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    func allignKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view!.frame.origin.y == 0 {
                self.view!.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view!.frame.origin.y != 0 {
            self.view!.frame.origin.y = 0
        }
    }
    
    func getCurrentTime() -> String{
       
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        return String(hour) + ":" + String(minutes)
    }
    
    func getCurrentDate() -> String{
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        return String(day) + "-" + String(month) + "-" + String(year)
    }
    
    func showToast(message : String, view: UIView) {
        
        let toastLabel = UILabel(frame: CGRect(x: 16, y: view.frame.size.height-100, width: view.frame.size.width - 32, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    func showErrorToast(message : String, view: UIView) {
        
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 15.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 0;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            //toastLabel.alpha = 0.0
            toastLabel.frame = CGRect(x: 0, y: 30, width:view.frame.size.width, height: 45)
        }, completion: {(isCompleted) in
            
            UIView.animate(withDuration: 4.0, animations: {
                toastLabel.alpha = 0.0
            }, completion : {isCompleted in
                toastLabel.removeFromSuperview()
            })
            
        })
    }
    
    func showErrorToast(message : String, view: UIView, startY : CGFloat, endY : CGFloat) {
        
        let toastLabel = UILabel(frame: CGRect(x: 0, y: startY, width: view.frame.size.width, height: 45))
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 15.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 0;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            //toastLabel.alpha = 0.0
            toastLabel.frame = CGRect(x: 0, y: endY, width:view.frame.size.width, height: 45)
        }, completion: {(isCompleted) in
            
            UIView.animate(withDuration: 4.0, animations: {
                toastLabel.alpha = 0.0
            }, completion : {isCompleted in
                toastLabel.removeFromSuperview()
            })
            
        })
    }
    
    func showConfirmAlert(view : UIViewController, title : String , alert : String, confirmAction: @escaping () -> () ){
        // create the alert
        let alert = UIAlertController(title: title, message: alert, preferredStyle: UIAlertController.Style.actionSheet)
        
        // add an action (button)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: {
            action in
            confirmAction()
        }))
        
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }

    func getFCMToken(){
        if CFtoken.isEmpty {
        let fcmtoken =  Messaging.messaging().fcmToken
        CFtoken = String( describing: fcmtoken ?? "" )
        print(CFtoken)
        } 
    }
 
}
