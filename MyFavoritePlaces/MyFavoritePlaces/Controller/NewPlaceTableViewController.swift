//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    
    let newPlaceCellID = "newPlaceCellID"
    
    var placeHeaderImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
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
        setupTableView()
        setupNavigation()
    }
    
    func setupTableView() {
        tableView.rowHeight = 75
        tableView.register(NewPlaceTableViewCell.self, forCellReuseIdentifier: newPlaceCellID)
        
        placeHeaderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 0.85))
        
        tableView.tableHeaderView = placeHeaderImageView
    }
    
    func setupNavigation() {
        navigationItem.titleView = titleHeader
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceCellID, for: indexPath) as! NewPlaceTableViewCell
        
        cell.placeTitleLabel.text = "\(indexPath.row)"
        cell.placeTextField.text = "\(indexPath.row)"
        return cell
    }
}
