//
//  NotificationTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/1/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img_sender: UIImageView!
    
    
    @IBOutlet weak var lbl_cotent: UILabel!
    
    @IBOutlet weak var lbl_time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(content : String, time: String, isMyMessage : Bool) {
        
        lbl_cotent.text = content
        lbl_time.text = time
        if isMyMessage {
            img_sender.image = #imageLiteral(resourceName: "unknow_100")
        }
        /*
        else {
            imageView?.image = #imageLiteral(resourceName: "logo_circle")
        }
 */
        imageView?.contentMode = .scaleAspectFill
    }

}
