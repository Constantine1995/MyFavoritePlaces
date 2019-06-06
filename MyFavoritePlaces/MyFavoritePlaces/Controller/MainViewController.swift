//
//  MainTableViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/29/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var places: Results<FavoritePlace>!
    
    var favoritePlaceCellId = "favoritePlaceCellId"
    var ascendingSorting = true
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let titleHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Favorite Places"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var reverseSortingPlaceButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        return barButton
    }()
    
    var addNewPlaceButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        return barButton
    }()
    
    var sortSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        places = realm.objects(FavoritePlace.self)
        setupSegmentedControl()
        setupTableView()
        setupNotificationCenter()
        setupNavigation()
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "reloadBeforeSaveToRealm"), object: nil)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.setAnchor(top: sortSegmentedControl.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritePlaceTableViewCell.self, forCellReuseIdentifier: favoritePlaceCellId)
        tableView.separatorStyle = .none
    }
    
    func setupSegmentedControl() {
        let items = ["Date" , "Name"]
        sortSegmentedControl = UISegmentedControl(items : items)
        sortSegmentedControl.selectedSegmentIndex = 0
        sortSegmentedControl.addTarget(self, action: #selector(sortSelection), for: .valueChanged)
        view.addSubview(sortSegmentedControl)
        sortSegmentedControl.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
        
    }
    func setupNavigation() {
        navigationItem.titleView = titleHeader
        reverseSortingPlaceButton = UIBarButtonItem(image: #imageLiteral(resourceName: "AZ"), style: .plain, target: self, action: #selector(reversedSorting))
        navigationItem.leftBarButtonItem = reverseSortingPlaceButton
        addNewPlaceButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToNewPlace))
        navigationItem.rightBarButtonItem = addNewPlaceButton
    }
    
    private func sorting() {
        if sortSegmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableView.reloadData()
    }
    
    @objc func goToNewPlace() {
        let newPlaceTableViewController = UINavigationController(rootViewController: NewPlaceTableViewController())
        newPlaceTableViewController.modalTransitionStyle = .flipHorizontal
        navigationController?.present(newPlaceTableViewController, animated: true)
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoritePlaceCellId, for: indexPath) as! FavoritePlaceTableViewCell
        
        let place = places[indexPath.item]
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.placeImageView.image = UIImage(data: place.imageData!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newPlaceTableViewController = NewPlaceTableViewController()
        let newPlaceNavigationController = UINavigationController(rootViewController: newPlaceTableViewController)
        newPlaceNavigationController.modalTransitionStyle = .flipHorizontal
        let place = places[indexPath.item]
        newPlaceTableViewController.currentPlace = place
        navigationController?.present(newPlaceNavigationController, animated: true)
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
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
    
    @objc func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @objc func reversedSorting(_ sender: Any) {
        ascendingSorting.toggle()
        if ascendingSorting {
            reverseSortingPlaceButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reverseSortingPlaceButton.image = #imageLiteral(resourceName: "ZA")
        }
        sorting()
    }
    
}
