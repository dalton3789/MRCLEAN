//
//  AccountTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/8/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img_icon: UIImageView!
    
    @IBOutlet weak var lbl_info: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    
   public func setData(img : UIImage, info : String){
        img_icon.image = img
        lbl_info.text = info
    }

}
