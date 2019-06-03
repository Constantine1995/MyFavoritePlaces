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
    
    let placeName = [
    "celentano", "Burger House", "Fransua"
    ]
    
    func savePlaces() {
        
        for place in placeName {
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }
            let newPlace = FavoritePlace()
            newPlace.name = place
            newPlace.location = "Melitopol"
            newPlace.type = "Restaurant"
            newPlace.imageData = imageData
            StorageManager.saveObject(newPlace)
        }
    }
}
