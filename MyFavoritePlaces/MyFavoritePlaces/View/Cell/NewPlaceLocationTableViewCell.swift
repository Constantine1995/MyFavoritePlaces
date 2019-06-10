//
//  NewPlaceLocationTableViewCell.swift
//  MyFavoritePlaces
//
//  Created by mac on 6/5/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NewPlaceLocationTableViewCell: UITableViewCell {

    class var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var placeTextLabel: UILabel!
    @IBOutlet weak var placeLocationTextField: UITextField!
    @IBOutlet weak var UserLocation: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
