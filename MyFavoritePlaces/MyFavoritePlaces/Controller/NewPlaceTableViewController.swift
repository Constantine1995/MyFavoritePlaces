//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    
    let newPlaceImageCellId = "newPlaceImageCellId"
    let newPlaceInfoCellId = "newPlaceInfoCellId"
    let placeImageNameNib = "NewPlaceImageTableViewCell"
    let placeInfoNameNib = "NewPlaceInfoTableViewCell"
    
    let placeCellHeaderData: [PlaceCellHeaderData] = PlaceCellHeaderData.fetchData()
    
    let titleHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Favorite Places"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let placeNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let placeLocationTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let placeTypeTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let placeImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Photo"))
        return imageView
    }()
    
    var saveBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        //        barButton.isEnabled = false
        return barButton
    }()
    
    var cancelBarButtonItem:  UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
    }
    
    func setupTableView() {
        let placeImageNib = UINib(nibName: placeImageNameNib, bundle: nil)
        let placeInfoNib = UINib(nibName: placeInfoNameNib, bundle: nil)
        tableView.register(placeImageNib, forCellReuseIdentifier: newPlaceImageCellId)
        tableView.register(placeInfoNib, forCellReuseIdentifier: newPlaceInfoCellId)
        tableView.tableFooterView = UIView()
    }
    
    func setupNavigation() {
        navigationItem.titleView = titleHeader
        cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        
        saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        saveBarButtonItem.isEnabled = false
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    func setupView() {
        placeNameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.item  {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceImageCellId, for: indexPath) as! NewPlaceImageTableViewCell
            cell.placeImageView.image = placeImageView.image
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceInfoCellId, for: indexPath)  as! NewPlaceInfoTableViewCell
            let index = indexPath.item-1
            cell.placeTextLabel.text = placeCellHeaderData[index].title
            cell.placeTextField.placeholder = placeCellHeaderData[index].placeholder
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let photoFromCamera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            let photoFromGallery = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            photoFromCamera.setValue(cameraIcon, forKey: "image")
            photoFromCamera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            photoFromGallery.setValue(photoIcon, forKey: "image")
            photoFromGallery.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(photoFromCamera)
            actionSheet.addAction(photoFromGallery)
            actionSheet.addAction(cancel)
            present(actionSheet, animated:  true)
            
        } else {
            view.endEditing(true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 250
        } else {
            return 75
        }
    }
    
    @objc private func cancelAction(_ : UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func textFieldChanged() {
        
        if placeNameTextField.text?.isEmpty == false {
            saveBarButtonItem.isEnabled = true
        } else {
            saveBarButtonItem.isEnabled = false
        }
    }
}
