//
//  ConfirmBookingableViewCell.swift
//  Clean
//
//  Created by Toan Nguyen on 6/13/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class ConfirmBookingableViewCell: UITableViewCell {

    
    @IBOutlet weak var image_icon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(image : UIImage, description : String){
        image_icon.image = image
        descriptionLabel.text = description
    }

}
