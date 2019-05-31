//
//  PlaceInfoCell.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/31/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct PlaceCellHeaderData {
    
    var title: String
    var placeholder: String
    
    static func fetchData() -> [PlaceCellHeaderData] {
        let name = PlaceCellHeaderData(title: "Name", placeholder: "Place name")
        let location = PlaceCellHeaderData(title: "Location", placeholder: "Place location")
        let type = PlaceCellHeaderData(title: "Type", placeholder: "Place type")

        return [name, location, type]
    }
}
