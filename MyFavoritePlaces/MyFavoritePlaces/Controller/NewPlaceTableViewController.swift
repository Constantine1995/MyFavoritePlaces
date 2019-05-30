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
        let image = UIImageView(image: #imageLiteral(resourceName: "celentano"))
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .gray
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
        tableView.register(NewPlaceTableViewCell.self, forCellReuseIdentifier: newPlaceCellID)
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 75
            placeHeaderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 0.85))
//        placeHeaderImageView.image = #imageLiteral(resourceName: "celentano")
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
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.placeTitleLabel.text = "place holder \(indexPath.row)"
        cell.placeTextField.text = "place holder \(indexPath.row)"
        cell.placeTextField.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }
}
