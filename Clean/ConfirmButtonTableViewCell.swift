//
//  ConfirmButtonTableViewCell.swift
//  Clean
//
//  Created by Dalton Nguyen on 6/14/19.
//  Copyright © 2019 James. All rights reserved.
//

import UIKit

class ConfirmButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var confirmButton: UIButton!
    var controller: UINavigationController? 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        confirmButton.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func close(_ sender: UIButton) {
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        controller?.present(newViewController, animated: true, completion: nil)
    }
}
