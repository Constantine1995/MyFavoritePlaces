//
//  StorageManager.swift
//  MyFavoritePlaces
//
//  Created by mac on 6/3/19.
//  Copyright © 2019 mac. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: FavoritePlace) {
        try! realm.write {
            realm.add(place)
        }
    }
}
