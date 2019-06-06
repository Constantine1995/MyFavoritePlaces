//
//  MainViewController+UISearchResultUpdating.swift
//  MyFavoritePlaces
//
//  Created by mac on 6/6/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)  
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filterPlaces = places.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText, searchText)
        tableView.reloadData()
    }
}
