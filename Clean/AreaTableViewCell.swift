//
//  AreaTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 4/7/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class AreaTableViewCell: UITableViewCell {

    @IBOutlet weak var txt_area: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getValue() -> String {
        return txt_area.text!
    }

}
