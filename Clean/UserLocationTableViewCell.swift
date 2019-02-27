//
//  UserLocationTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/23/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class UserLocationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_location: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLocation(location : String) {
        lbl_location.text = location
    }

}
