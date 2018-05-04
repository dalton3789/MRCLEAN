//
//  Config.swift
//  Clean
//
//  Created by James on 7/24/17.
//  Copyright © 2017 James. All rights reserved.
//

import Foundation
import UIKit


var dataUser = DataUser()
var server = Server()
var response = Message()
var userValidate = UserValidation()
let alertMain = UIAlertController()
var CFListNewMessage = Array<CFNewMessage>()
var newMessage = CFNewMessage()
var datepicker = UIDatePicker()
let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

var isInit = 0
var isSendTokenToServer = 0
var CFtoken = ""
var CFMessageTopicID = ""


struct Config{
    //static let destination = "http://192.168.1.58:8383/cleaning"
   static let destination = "https://cleanhome.com.vn"
    
    static var MessageId = ""
    
    

}

struct CFResponseFromMMC{
    static var id = ""
    static var customer_id = ""
    static var topic_id = ""
    static var content = ""
    static var title = ""
    static var time = ""
    static var isRead = ""
    static var isReplied = ""
}

struct CFNewMessage{
    var id = ""
    var customer_id = ""
    var topic_id = ""
    var content = ""
    var title = ""
    var time = ""
    var isRead = ""
    var isReplied = ""
}






func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


func Initialize(){
    isInit = 1
    alertMain.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))

}


