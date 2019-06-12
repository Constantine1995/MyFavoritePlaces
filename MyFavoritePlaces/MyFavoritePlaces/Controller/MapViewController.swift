//
//  MapViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 6/9/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    var delegate: MapViewControllerDelegate?
    var place = FavoritePlace()
    let placeMKMapView = MKMapView(frame: .zero)
    var isTransitionWithMapGetAdress = false
    var previousLocation: CLLocation? {
        didSet {
            MapManager.shared.startTrackingUserLocation(for: placeMKMapView, and: previousLocation) { (currentLocation) in
                self.previousLocation = currentLocation
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    MapManager.shared.showUserLocation(mapView: self.placeMKMapView)
                }
            }
        }
    }
    
    let closeButton: UIButton =  {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        return button
    }()
    
    let doneButton: UIButton =  {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    let goButton: UIButton =  {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "GetDirection"), for: .normal)
        return button
    }()
    
    let userLocationButton: UIButton =  {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Location"), for: .normal)
        return button
    }()
    
    let mapPinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Pin")
        return imageView
    }()
    
    let currentAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeMKMapView.delegate = self
        setupView()
        setupMapView()
    }
    
    override func loadView() {
        view = placeMKMapView
        view.frame.size = UIScreen.main.bounds.size
    }
    
    private func setupView() {
        view.addSubview(closeButton)
        view.addSubview(userLocationButton)
        view.addSubview(mapPinImageView)
        view.addSubview(currentAddressLabel)
        view.addSubview(doneButton)
        view.addSubview(goButton)
        
        closeButton.addTarget(self, action: #selector(closeArction), for: .touchUpInside)
        closeButton.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, right: view.rightAnchor, bottom: nil, paddingTop: 40, paddingLeft: 0, paddingRight: -40, paddingBottom: 0, width: 30, height: 30)
        
        userLocationButton.addTarget(self, action: #selector(centerViewInuserLocationAction), for: .touchUpInside)
        userLocationButton.setAnchor(top: nil, left: nil, right: view.rightAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: -40, paddingBottom: -40, width: 30, height: 30)
        
        mapPinImageView.setSize(width: 40, height: 40)
        mapPinImageView.setCenterXAnchor(view)
        mapPinImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        
        currentAddressLabel.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 100, paddingLeft: 8, paddingRight: -8, paddingBottom: 0)
        
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        doneButton.setAnchor(top: nil, left: nil, right: nil, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -80)
        doneButton.setCenterXAnchor(view)
        
        goButton.setAnchor(top: nil, left: nil, right: nil, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -40, width: 50, height: 50)
        goButton.setCenterXAnchor(view)
        goButton.addTarget(self, action: #selector(goButtonAction), for: .touchUpInside)
        
    }
    
  
    
    private func setupMapView() {
        goButton.isHidden = true

        MapManager.shared.checkLocationServices(mapView: placeMKMapView, isTransitionWithMapGetAdress: isTransitionWithMapGetAdress) {
            MapManager.shared.locationManager.delegate = self
        }
        
        if !isTransitionWithMapGetAdress {
            MapManager.shared.setupPlacemark(place: place, mapView: placeMKMapView)
            mapPinImageView.isHidden = true
            currentAddressLabel.isHidden = true
            doneButton.isHidden = true
            goButton.isHidden = false
        }
    }
    
    @objc func closeArction() {
        dismiss(animated: true)
    }
    
    @objc func centerViewInuserLocationAction() {
        MapManager.shared.showUserLocation(mapView: placeMKMapView)
    }
    
    @objc func doneAction() {
        delegate?.getAddress(currentAddressLabel.text)
        dismiss(animated: true)
    }
    
    @objc func goButtonAction() {
        MapManager.shared.getDirections(mapView: placeMKMapView) { (location) in
            self.previousLocation = location
        }
    }
}
