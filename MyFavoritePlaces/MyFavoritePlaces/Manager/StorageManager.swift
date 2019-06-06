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
    
    static let shared = StorageManager()
    
    private init(){}
    
    func saveObject(_ place: FavoritePlace) {
        try! realm.write {
            realm.add(place)
        }
    }
    
    func deleteObject(_ place: FavoritePlace) {
        try! realm.write {
            realm.delete(place)
        }
    }
    
}
