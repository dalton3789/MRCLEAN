//
//  PersonInfoTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/26/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class PersonInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl_personalInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setPersonalInfo( info : String) {
        lbl_personalInfo.text = info
    }
    
}
