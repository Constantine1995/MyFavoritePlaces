//
//  NewPlaceImageTableViewCell.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/31/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NewPlaceImageTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
