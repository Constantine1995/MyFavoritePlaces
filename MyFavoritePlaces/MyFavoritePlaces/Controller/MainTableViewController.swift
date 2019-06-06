//
//  MainTableViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    var places: Results<FavoritePlace>!
    
    var favoritePlaceCellId = "favoritePlaceCellId"
    
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
        places = realm.objects(FavoritePlace.self)
        setupNotificationCenter()
        setupTableView()
        setupNavigation()
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "reloadBeforeSaveToRealm"), object: nil)
    }
    
    func setupTableView() {
        tableView.register(FavoritePlaceTableViewCell.self, forCellReuseIdentifier: favoritePlaceCellId)
        tableView.separatorStyle = .none
    }
    
    func setupNavigation() {
        navigationItem.titleView = titleHeader
        let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToNewPlace))
        navigationItem.rightBarButtonItem = rightAddButton
    }
    
    @objc func goToNewPlace() {
        let newPlaceTableViewController = UINavigationController(rootViewController: NewPlaceTableViewController())
        newPlaceTableViewController.modalTransitionStyle = .flipHorizontal
        navigationController?.present(newPlaceTableViewController, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoritePlaceCellId, for: indexPath) as! FavoritePlaceTableViewCell
        
        let place = places[indexPath.item]
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.placeImageView.image = UIImage(data: place.imageData!)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newPlaceTableViewController = NewPlaceTableViewController()
        let newPlaceNavigationController = UINavigationController(rootViewController: newPlaceTableViewController)
        newPlaceNavigationController.modalTransitionStyle = .flipHorizontal
        let place = places[indexPath.item]
        newPlaceTableViewController.currentPlace = place
        navigationController?.present(newPlaceNavigationController, animated: true)
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let place = places[indexPath.item]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.shared.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    @objc func reloadTableView(){
        self.tableView.reloadData()
    }
}
