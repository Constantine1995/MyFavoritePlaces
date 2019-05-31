//
//  NewPlaceInfoTableViewCell.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/31/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NewPlaceInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var placeTextLabel: UILabel!
    @IBOutlet weak var placeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        placeTextField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
