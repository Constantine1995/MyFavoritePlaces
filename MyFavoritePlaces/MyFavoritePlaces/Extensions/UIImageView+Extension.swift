//
//  UIImageView+Extension.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension UIImageView {
    func imageViewCorners() {
        layer.cornerRadius = 50
        layer.masksToBounds = true
    }
}
