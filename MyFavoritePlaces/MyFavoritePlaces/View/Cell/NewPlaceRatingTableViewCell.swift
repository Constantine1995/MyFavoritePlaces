//
//  NewPlaceRatingTableViewCell.swift
//  MyFavoritePlaces
//
//  Created by mac on 6/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NewPlaceRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingControl: RatingControl!
    
    class var identifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
