//
//  MapViewController.swift
//  MyFavoritePlaces
//
//  Created by mac on 6/9/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var place: FavoritePlace!
    let placeMKMapView = MKMapView(frame: .zero)
    
    class var identifier: String {
        return String(describing: self)
    }
    
    let closeButton: UIButton =  {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeMKMapView.delegate = self
        setupView()
        setupPlacemark()
    }
    
    override func loadView() {
        view = placeMKMapView
        view.frame.size = UIScreen.main.bounds.size
    }
    
    func setupView() {
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeArction), for: .touchUpInside)
        closeButton.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, right: view.rightAnchor, bottom: nil, paddingTop: 40, paddingLeft: 0, paddingRight: -40, paddingBottom: 0, width: 30, height: 30)
    }
    
    private func setupPlacemark() {
        guard let location = place.location else { return }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            let annotation = MKPointAnnotation()
            annotation.title = self.place.name
            annotation.subtitle = self.place.type
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.placeMKMapView.showAnnotations([annotation], animated: true)
            self.placeMKMapView.selectAnnotation(annotation, animated: true)
            
        }
    }
    
    @objc func closeArction() {
        dismiss(animated: true)
    }
}
