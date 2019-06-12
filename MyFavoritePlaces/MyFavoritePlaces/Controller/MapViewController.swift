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
    let locationManager = CLLocationManager()
    var isTransitionWithMapGetAdress = false
    let regionInMeters = 10_000.00
    var placeCoordinate: CLLocationCoordinate2D?
    
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
        checkLocationServices()
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
        
        userLocationButton.addTarget(self, action: #selector(locationAction), for: .touchUpInside)
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
            self.placeCoordinate = placemarkLocation.coordinate
            self.placeMKMapView.showAnnotations([annotation], animated: true)
            self.placeMKMapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    private func setupMapView() {
        
        goButton.isHidden = true
        
        if !isTransitionWithMapGetAdress {
            setupPlacemark()
            mapPinImageView.isHidden = true
            currentAddressLabel.isHidden = true
            doneButton.isHidden = true
            goButton.isHidden = false
        }
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else  {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(
                    title: "Location Services are Disabled",
                    message: "To enable it go: Settings -> Privace -> Location Services and turn On")
            }
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func showUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            placeMKMapView.setRegion(region, animated: true)
        }
    }
    
    internal func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            placeMKMapView.showsUserLocation = true
            if isTransitionWithMapGetAdress {
                showUserLocation()
            }
            break
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(
                    title: "Your Location is not Available",
                    message: "To give permission Go to: Settings -> MyPlace -> Location")
            }
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            print("New case is available")
        }
    }
    
    private func getDirections() {
        guard let location = locationManager.location?.coordinate else {
            showAlert(title: "Error", message: "Current location is not found")
            return
        }
        
        guard let request = createDirectionRequest(from: location) else {
            showAlert(title: "Error", message: "Destination is not found")
            return
        }
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let response = response else {
                self.showAlert(title: "Error", message: "Dirrections is not available")
                return
            }
            for route in response.routes {
                self.placeMKMapView.addOverlay(route.polyline)
                self.placeMKMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
                let distance = String(format: "%.1f", route.distance / 1000)
                let timeInterval = route.expectedTravelTime
                print("Расстояние до места: \(distance) км.")
                print("Время в пути составит \(timeInterval) сек")
            }
        }
    }
    
    private func createDirectionRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request? {
        guard let destinationCoordinate = placeCoordinate else { return nil }
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    
    internal func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude =  mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func closeArction() {
        dismiss(animated: true)
    }
    
    @objc func locationAction() {
        showUserLocation()
    }
    
    @objc func doneAction() {
        delegate?.getAddress(currentAddressLabel.text)
        dismiss(animated: true)
    }
    
    @objc func goButtonAction() {
        getDirections()
    }
}
