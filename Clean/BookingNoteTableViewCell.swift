//
//  BookingNoteTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/26/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class BookingNoteTableViewCell: UITableViewCell, UITextViewDelegate {

   
    @IBOutlet weak var txt_note: UITextView!
    
    let shareAction = SharedFunctions()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        txt_note.text = "Chi tiết công việc"
        txt_note.textColor = UIColor.gray
        txt_note.delegate = self
        
        shareAction.view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        shareAction.allignKeyboard()

        // Configure the view for the selected state
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txt_note.text == "Chi tiết công việc" {
            txt_note.text = ""
            txt_note.textColor = UIColor.black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UserDefaults.standard.set(txt_note.text!, forKey: GlobalValues().booking_note)
    }

}
