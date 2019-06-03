//
//  NewPlaceInfoTableViewCell.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/31/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

protocol SwitchDelegate {
    func didFinishEditing(text: String)
}


class NewPlaceInfoTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var placeTextLabel: UILabel!
    @IBOutlet weak var placeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
