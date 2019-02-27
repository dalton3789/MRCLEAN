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

    public func setBottomBorder(view : UIView) {
        //view.borderStyle = .none
        view.layer.backgroundColor = UIColor.white.cgColor
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
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
}
