//
//  DateTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 2/25/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDate(date : String) {
        
        lbl_date.text = date
    }

}
