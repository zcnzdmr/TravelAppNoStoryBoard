//
//  RegisterPage.swift
//  TravelBookDeneme
//
//  Created by Özcan on 25.04.2024.
//

import UIKit
import MapKit
import CoreLocation

class RegisterPage: UIViewController {
    
    var viewModel = RegisterViewModel()
    
    var mapKit = MKMapView()
    var locationManager = CLLocationManager()
    
    var saveButon = UIButton()
    var nameOfPlace = UITextField()
    var typeOfPlace = UITextField()
    
    var latitude = String()
    var longitude = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIObjects()
        location()
        tapGesture()
    }
    
    func tapGesture() {
        mapKit.isUserInteractionEnabled = true
        let gR = UILongPressGestureRecognizer(target: self, action: #selector(markLocation))
        gR.minimumPressDuration = 2
        mapKit.addGestureRecognizer(gR)
    }
    
    @objc func markLocation() {
        
        let pin = MKPointAnnotation()
        
        if let x = Double(latitude), let y = Double(longitude) {
            let konum = CLLocationCoordinate2D(latitude: x, longitude: y)
            pin.coordinate = konum
            if nameOfPlace.text != nil && typeOfPlace.text != nil {
                pin.title = nameOfPlace.text
                pin.subtitle = typeOfPlace.text
            }
            mapKit.addAnnotation(pin)
        }
    }
    
    private func setUpUIObjects() {
        
        view.backgroundColor = .systemBackground
        let screenWidth = view.frame.size.width
        
        //        mapKit.frame = CGRect(x: 0, y: 280, width: screenWidth, height: 420)
        //        let konum = CLLocationCoordinate2D(latitude: 41.0370175, longitude: 28.974792)
        //        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        //        let bolge = MKCoordinateRegion(center: konum, span: span)
        //        mapKit.setRegion(bolge, animated: true)
        //        view.addSubview(mapKit)
        
        saveButon.frame = CGRect(x: (screenWidth - 60 ) / 2, y: 750, width: 60, height: 30)
        saveButon.setTitle("Save", for: UIControl.State.normal)
        saveButon.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        saveButon.addTarget(self, action: #selector(save), for: UIControl.Event.touchUpInside)
        view.addSubview(saveButon)
        
        nameOfPlace.frame = CGRect(x: (screenWidth - 310) / 2, y: 140, width: 310, height: 35)
        nameOfPlace.placeholder = "Name of place"
        nameOfPlace.layer.borderWidth = 0.4
        view.addSubview(nameOfPlace)
        
        typeOfPlace.frame = CGRect(x: (screenWidth - 310) / 2, y: 190, width: 310, height: 35)
        typeOfPlace.placeholder = "Type of place"
        typeOfPlace.layer.borderWidth = 0.4
        view.addSubview(typeOfPlace)
    }
    
    func location() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    @objc func save() {
        if let x = nameOfPlace.text , let y = typeOfPlace.text {
            viewModel.save(nameOfPlace: x, typeOfPlace: y, latitudeOfPlace: latitude, longitudeOfPlace: longitude)
        }
    }
}

extension RegisterPage : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let theLastLocation = locations[locations.count-1]
        
        //mapkite konum verme ve span yani zoomunu ayarlama kısmı
        let enlem = theLastLocation.coordinate.latitude
        let boylam = theLastLocation.coordinate.longitude
        
        latitude = String(enlem)
        longitude = String(boylam)
        
        mapKit.frame = CGRect(x: 0, y: 280, width: screenWidth, height: 420)
        let konum = CLLocationCoordinate2D(latitude: enlem, longitude: boylam)
        print(enlem)
        print(boylam)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let bolge = MKCoordinateRegion(center: konum, span: span)
        mapKit.setRegion(bolge, animated: true)
        view.addSubview(mapKit)

    }
}
