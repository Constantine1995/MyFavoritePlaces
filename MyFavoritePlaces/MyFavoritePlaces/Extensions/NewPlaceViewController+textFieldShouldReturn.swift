//
//  NewPlaceViewController+textFieldShouldReturn.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension NewPlaceTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
