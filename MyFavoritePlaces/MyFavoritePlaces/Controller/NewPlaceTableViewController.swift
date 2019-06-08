//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 5/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RealmSwift

class NewPlaceTableViewController: UITableViewController, RatingProtocol {

    var currentRating = 0
    
    let newPlaceImageCellId = "newPlaceImageCellId"
    let newPlaceNameCellId = "newPlaceNameCellId"
    let newPlaceLocationCellId = "newPlaceLocationCellId"
    let newPlaceTypeCellId = "newPlaceTypeCellId"
    let newPlaceRatingCellId = "newPlaceRatingCellId"
    
    let placeCellHeaderData: [PlaceCellHeaderData] = PlaceCellHeaderData.fetchData()
    var imageIsChanged = false
    var currentPlace: FavoritePlace?
    var ratingCell: NewPlaceRatingTableViewCell?
    var countCell = 5
    
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
    
    var cancelBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        return barButton
    }()
    
    var undoBarButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
    }
    
    func setupTableView() {
        let placeImageNib = UINib(nibName: NewPlaceImageTableViewCell.identifier, bundle: nil)
        let placeNameNib = UINib(nibName: NewPlaceNameTableViewCell.identifier, bundle: nil)
        let placeLocationNib = UINib(nibName: NewPlaceLocationTableViewCell.identifier, bundle: nil)
        let placeTypeNib = UINib(nibName: NewPlaceTypeTableViewCell.identifier, bundle: nil)
        let placeRatingNib = UINib(nibName: NewPlaceRatingTableViewCell.identifier, bundle: nil)
    
        tableView.register(placeImageNib, forCellReuseIdentifier: newPlaceImageCellId)
        tableView.register(placeNameNib, forCellReuseIdentifier: newPlaceNameCellId)
        tableView.register(placeTypeNib, forCellReuseIdentifier: newPlaceTypeCellId)
        tableView.register(placeLocationNib, forCellReuseIdentifier: newPlaceLocationCellId)
        tableView.register(placeRatingNib, forCellReuseIdentifier: newPlaceRatingCellId)

        tableView.tableFooterView = UIView()
    }
    
    func setupNavigation() {
        navigationItem.titleView = titleHeader
        if currentPlace == nil {
            cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
            navigationItem.leftBarButtonItem = cancelBarButtonItem
        }
        saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        saveBarButtonItem.isEnabled = false
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.item-1
        
        switch indexPath.item  {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceImageCellId, for: indexPath) as! NewPlaceImageTableViewCell
            setupEditScreen(placeImage: placeImageView, name: nil, location: nil, type: nil)
            cell.placeImageView.image = placeImageView.image
            configureCell(cell)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceNameCellId, for: indexPath)  as! NewPlaceNameTableViewCell
            placeNameTextField = cell.placeNameTextField
            setupEditScreen(placeImage: nil, name: placeNameTextField, location: nil, type: nil)
            configureCell(cell)
            cell.placeNameTextField.delegate = self
            cell.placeTextLabel.text = placeCellHeaderData[index].title
            cell.placeNameTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceLocationCellId, for: indexPath)  as! NewPlaceLocationTableViewCell
            placeLocationTextField = cell.placeLocationTextField
            setupEditScreen(placeImage: nil, name: nil, location: placeLocationTextField, type: nil)
            cell.placeLocationTextField.delegate = self
            cell.placeTextLabel.text = placeCellHeaderData[index].title
            configureCell(cell)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceTypeCellId, for: indexPath)  as! NewPlaceTypeTableViewCell
            placeTypeTextField = cell.placeTypeTextField
            setupEditScreen(placeImage: nil, name: nil, location: nil, type: placeTypeTextField)
            cell.placeTypeTextField.delegate = self
            cell.placeTextLabel.text = placeCellHeaderData[index].title
            configureCell(cell)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: newPlaceRatingCellId, for: indexPath)  as! NewPlaceRatingTableViewCell
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat.greatestFiniteMagnitude)
            cell.directionalLayoutMargins = .zero
            cell.ratingControl.delegate = self
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
        switch indexPath.item {
        case 0:
              return 250
        case 1...3:
            return 75
        default:
            return 140
        }
    }
    
    private func configureCell(_ cell: UITableViewCell) {
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    private func setupEditScreen(placeImage: UIImageView?, name: UITextField?, location: UITextField?, type: UITextField?) {
        if currentPlace != nil {
            setupNavigationBar()
            imageIsChanged = true
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            placeImage?.image = image
            name?.text = currentPlace?.name
            location?.text = currentPlace?.location
            type?.text = currentPlace?.type
        }
    }
    
    private func setupNavigationBar() {
        undoBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem = undoBarButtonItem
        titleHeader.text = currentPlace?.name
        saveBarButtonItem.isEnabled = true
    }
    
    func savePlace() {
        var image: UIImage?
        
        if imageIsChanged {
            image = placeImageView.image
        } else {
            image = #imageLiteral(resourceName: "not-pace")
        }
//        let rating = ratingDelegate?.rating
        let imageData = image?.pngData()
        let newPlace = FavoritePlace(name: placeNameTextField.text!, location: placeLocationTextField.text, type: placeTypeTextField.text, imageData: imageData, rating: Double(currentRating))
        print("rating in model \(currentRating)")
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
                currentPlace?.rating = newPlace.rating
            }
        } else {
            StorageManager.shared.saveObject(newPlace)
        }
    }
    
    @objc private func cancelAction(_ : UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveAction(_ : UIButton) {
        savePlace()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadBeforeSaveToRealm"), object: nil)
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
