//
//  CustomerBookingTableViewCell.swift
//  Clean
//
//  Created by Nguyen, Toan on 3/3/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class CustomerBookingTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var img_icon: UIImageView!
    
    
    @IBOutlet weak var lbl_detail: UILabel!
    
    
    @IBOutlet weak var lbl_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(detail : String, date : String){
        
        lbl_date.text = date
        lbl_detail.text = detail
    }

}
