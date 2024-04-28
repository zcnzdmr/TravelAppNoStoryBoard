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
    
    @objc func markLocation(gesRecog:UILongPressGestureRecognizer) {
        
        let pin = MKPointAnnotation()
        
        let touchedLocation = gesRecog.location(in: self.mapKit)
        let touchedCoordinate = mapKit.convert(touchedLocation, toCoordinateFrom: self.mapKit)
        
        latitude = String(touchedCoordinate.latitude)
        longitude = String(touchedCoordinate.longitude)
        
        
        pin.coordinate = touchedCoordinate
        if nameOfPlace.text != nil && typeOfPlace.text != nil {
            pin.title = nameOfPlace.text
            pin.subtitle = typeOfPlace.text
            mapKit.addAnnotation(pin)
        }
    }
    
    private func setUpUIObjects() {
        
        view.backgroundColor = .systemBackground
        let screenWidth = view.frame.size.width
        
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
    
    private func location() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    @objc func save() {
        if let x = nameOfPlace.text , let y = typeOfPlace.text {
            viewModel.save(nameOfPlace: x, typeOfPlace: y, latitudeOfPlace: latitude, longitudeOfPlace: longitude)
        }
//        self.navigationController?.show(HomePage(), sender: nil)
        NotificationCenter.default.post(name: NSNotification.Name("backTo"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }

}

extension RegisterPage : CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let theLastLocation = locations[locations.count-1]
        
        //mapkite konum verme ve span yani zoomunu ayarlama kısmı
        
        let enlem = theLastLocation.coordinate.latitude
        let boylam = theLastLocation.coordinate.longitude
        
        mapKit.frame = CGRect(x: 0, y: 280, width: screenWidth, height: 420)
        let konum = CLLocationCoordinate2D(latitude: enlem, longitude: boylam)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let bolge = MKCoordinateRegion(center: konum, span: span)
        mapKit.setRegion(bolge, animated: true)
        mapKit.delegate = self
        view.addSubview(mapKit)
        
    }
    
}
