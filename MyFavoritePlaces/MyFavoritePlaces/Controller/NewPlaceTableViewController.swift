//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RealmSwift

class NewPlaceTableViewController: UITableViewController {
    
    let newPlaceImageCellId = "newPlaceImageCellId"
    let newPlaceNameCellId = "newPlaceNameCellId"
    let newPlaceLocationCellId = "newPlaceLocationCellId"
    let newPlaceTypeCellId = "newPlaceTypeCellId"
    
    let placeCellHeaderData: [PlaceCellHeaderData] = PlaceCellHeaderData.fetchData()
    var imageIsChanged = false
    
    let titleHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Favorite Places"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var placeNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    var placeLocationTextField: UITextField = {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    var placeTypeTextField: UITextField = {
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
        setupView()
    }
    
    func setupTableView() {
        let placeImageNib = UINib(nibName:  NewPlaceImageTableViewCell.identifier, bundle: nil)
        let placeNameNib = UINib(nibName:  NewPlaceNameTableViewCell.identifier, bundle: nil)
        let placeLocationNib = UINib(nibName:  NewPlaceLocationTableViewCell.identifier, bundle: nil)
        let placeTypeNib = UINib(nibName:  NewPlaceTypeTableViewCell.identifier, bundle: nil)
        
        tableView.register(placeImageNib, forCellReuseIdentifier: newPlaceImageCellId)
        tableView.register(placeNameNib, forCellReuseIdentifier: newPlaceNameCellId)
        tableView.register(placeTypeNib, forCellReuseIdentifier: newPlaceTypeCellId)
        
        tableView.register(placeLocationNib, forCellReuseIdentifier: newPlaceLocationCellId)
        tableView.tableFooterView = UIView()
    }
    
    func setupNavigation() {
        navigationItem.titleView = titleHeader
        cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        
        saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        saveBarButtonItem.isEnabled = false
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    func setupView() {
        placeNameTextField.delegate = self
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
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceNameCellId, for: indexPath)  as! NewPlaceNameTableViewCell
            let index = indexPath.item-1
            placeNameTextField =  cell.placeNameTextField
            cell.placeTextLabel.text = placeCellHeaderData[index].title
            cell.placeNameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceLocationCellId, for: indexPath)  as! NewPlaceLocationTableViewCell
            let index = indexPath.item-1
            placeLocationTextField = cell.placeLocationTextField
            cell.placeTextLabel.text = placeCellHeaderData[index].title
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceTypeCellId, for: indexPath)  as! NewPlaceTypeTableViewCell
            let index = indexPath.item-1
            placeTypeTextField = cell.placeTypeTextField
            cell.placeTextLabel.text = placeCellHeaderData[index].title
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            return cell
        default:
            return UITableViewCell()
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
    
    @objc private func saveAction(_ : UIButton) {
        
        var image: UIImage?
        if imageIsChanged {
            image = placeImageView.image
        } else {
            image = #imageLiteral(resourceName: "not-pace")
        }
        
        let imageData = image?.pngData()
        print("-- \(placeTypeTextField.text!)")
        let newPlace = FavoritePlace(name: placeNameTextField.text!, location: placeLocationTextField.text, type: placeTypeTextField.text, imageData: imageData)
        StorageManager.saveObject(newPlace)
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
