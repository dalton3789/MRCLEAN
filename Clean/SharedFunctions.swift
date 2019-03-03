//
//  SharedFunctions.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/20/19.
//  Copyright © 2019 James. All rights reserved.
//

import Foundation
import UIKit

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
 
}
