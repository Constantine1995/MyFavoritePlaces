//
//  FavoritePlace.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import RealmSwift
import UIKit

class FavoritePlace: Object {
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
