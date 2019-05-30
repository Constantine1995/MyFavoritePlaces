//
//  MainTableViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var favoritePlaceCellId = "favoritePlaceCellId"
    
    var favoritePlaceData: [FavoritePlace] = FavoritePlace.fetchPlaces()
    
    let titleHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Favorite Places"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoritePlaceTableViewCell.self, forCellReuseIdentifier: favoritePlaceCellId)
        tableView.separatorStyle = .none
        
        setupNavigation()
    }
    
    func setupNavigation() {
        navigationItem.titleView = titleHeader
        let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToNewPlace))
        navigationItem.rightBarButtonItem = rightAddButton
    }
    
    @objc func goToNewPlace() {
        let newPlaceTableViewController = UINavigationController(rootViewController: NewPlaceTableViewController())
        navigationController?.present(newPlaceTableViewController, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoritePlaceData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoritePlaceCellId, for: indexPath) as! FavoritePlaceTableViewCell
        
        cell.nameLabel.text = favoritePlaceData[indexPath.item].name
        cell.locationLabel.text = favoritePlaceData[indexPath.item].location
        cell.typeLabel.text = favoritePlaceData[indexPath.item].type
        
        let imagePath = favoritePlaceData[indexPath.item].image
        cell.placeImageView.image = UIImage(named: imagePath)
        
        return cell
    }
}
