//
//  PopupDialogHelper.swift
//  Clean
//
//  Created by Dalton Nguyen on 6/19/19.
//  Copyright © 2019 James. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class PopupDialogHelper  {
    
    static var passDataDelegate : PassData?
    
    class func showImageDialog(title : String, message : String, image : UIImage, cancelAction : Void, doneAction : Void, viewController : UIViewController) {
        
        // Prepare the popup assets
        let title = title
        let message = message
        let image = image
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image, preferredWidth: 580)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL") {
            //self?.label.text = "You canceled the image dialog"
            cancelAction
        }
        
        // Create fourth (shake) button
        let buttonTwo = DefaultButton(title: "SHAKE", dismissOnTap: false) { [weak popup] in
            popup?.shake()
        }
        
        // Create second button
        let buttonThree = DefaultButton(title: "OK") {
            doneAction
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        
        // Present dialog
        viewController.present(popup, animated: true, completion: nil)
    }
    
    /*!
     Displays the default dialog without image, just as the system dialog
     */
    class func showStandardDialog(title : String, message : String, cancelAction : Void, doneAction : Void, viewController : UIViewController){
        
        // Prepare the popup
        let title = title
        let message = message
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true,
                                hideStatusBar: true) {
                                    print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL") {
            cancelAction
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "OK") {
            doneAction
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        viewController.present(popup, animated: true, completion: nil)
    }
    
    /*!
     Displays a custom view controller instead of the default view.
     Buttons can be still added, if needed
     */
    class func showCustomDialog(popupController : UIViewController, cancelAction : Void, doneAction : Void, viewController : UIViewController){
        
        // Create the dialog
        let popup = PopupDialog(viewController: popupController,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "HUỶ", height: 60) {
           cancelAction
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "XÁC NHẬN", height: 60) {
            doneAction
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        viewController.present(popup, animated: true, completion: nil)
    }
    
    class func showPersonalBookingInfoPopup(viewController : UIViewController, doneButton : Void, delegate : PassData) {
        self.passDataDelegate = delegate
        let popupDialog = PersonalBookingInfoViewController(nibName: "PersonalBookingInfo", bundle: nil)
        let popup = PopupDialog(viewController: popupDialog,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "HUỶ", height: 60) {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "XÁC NHẬN", height: 60) {
            UserDefaults.standard.set(popupDialog.txt_name.text!, forKey: GlobalValues().user_name)
            UserDefaults.standard.set(popupDialog.txt_phone.text!, forKey: GlobalValues().user_phone)
            self.passDataDelegate?.passData(data: "done")
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        viewController.present(popup, animated: true, completion: nil)
    }
    
    
    class func showMessageContentDialog(viewController : UIViewController, message : String){
        let popupDialog = MessageContentViewController(nibName: "MessageContent", bundle: nil)
        popupDialog.descripttionText = message
        let popup = PopupDialog(viewController: popupDialog,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "ĐÓNG", height: 60) {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "TRẢ LỜI", height: 60) {
         showMessageContentDialog(viewController : viewController)
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        viewController.present(popup, animated: true, completion: nil)
    }
    
    class func showMessageContentDialog(viewController : UIViewController){
        let popupDialog = SendMessagePopupViewController(nibName: "SendMessage", bundle: nil)

        let popup = PopupDialog(viewController: popupDialog,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "ĐÓNG", height: 60) {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "GỬI", height: 60) {
            popupDialog.sendMessage()
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        viewController.present(popup, animated: true, completion: nil)
    }
}
