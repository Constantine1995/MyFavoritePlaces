//
//  FavoritePlace.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

struct FavoritePlace {
    
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var placeImage: String?
    
    static func fetchPlaces() -> [FavoritePlace] {
        let celentano = FavoritePlace(name: "Celentano", location: "Melitopol", type: "Restaurant", image: nil, placeImage: "celentano")
        return [celentano]
    }
}
