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

    let placeMKMapView = MKMapView(frame: .zero)
    let closeButton: UIButton =  {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    
    @objc func closeArction() {
        dismiss(animated: true)
    }
}
