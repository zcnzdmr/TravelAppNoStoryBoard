//
//  DetailPage.swift
//  TravelBookDeneme
//
//  Created by Özcan Özdemir on 27.04.2024.
//

import UIKit
import MapKit
import CoreLocation


class DetailPage: UIViewController {
    
    var gelcekNesne : Travel?
    
    init(gelcekNesne:Travel) {
        super.init(nibName: nil, bundle: nil)
        self.gelcekNesne = gelcekNesne
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var mapKit = MKMapView()
    var name = UILabel()
    var type = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIObjects()
        
        mapKit.delegate = self
    }
    
    
    func setUpUIObjects() {
        
        let screenWidth = view.frame.size.width
        view.backgroundColor = .systemBackground
        
        
        mapKit.frame = CGRect(x: 0, y: 310, width: screenWidth, height: 480)
        view.addSubview(mapKit)
        
        if let travelNesnesi = gelcekNesne {
            
            //
            name.text = travelNesnesi.nameOfPlace
            type.text = travelNesnesi.typeOfPalce
            
            //mapkit konum gönderme ve point(pin) ekleme
            if let x = Double(travelNesnesi.latitudeOfPlace!), let y = Double(travelNesnesi.longitudeOfPlace!) {
                let konum = CLLocationCoordinate2D(latitude: x, longitude: y)
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let bolge = MKCoordinateRegion(center: konum, span: span)
                mapKit.setRegion(bolge, animated: true)
                
                let pin = MKPointAnnotation()
                pin.coordinate = konum
                pin.title = travelNesnesi.nameOfPlace
                pin.subtitle = travelNesnesi.typeOfPalce
                mapKit.addAnnotation(pin)
            }
        }
        
        name.frame = CGRect(x: (screenWidth - 340) / 2, y: 150, width: 340, height: 30)
        name.layer.borderWidth = 0.4
        view.addSubview(name)
        
        type.frame = CGRect(x: (screenWidth - 340) / 2, y: 210, width: 340, height: 30)
        type.layer.borderWidth = 0.4
        view.addSubview(type)
        
    }
}
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        if annotation is MKUserLocation { return nil }
//        
//        let identifier = "Annotation"
//        var annotationView = mapKit.dequeueReusableAnnotationView(withIdentifier: identifier)
//        
//        if annotationView == nil {
//            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            annotationView!.canShowCallout = true
//            
//        } else {
//            annotationView!.annotation = annotation
//        }
//        
//        let butonPin = UIButton(type: UIButton.ButtonType.detailDisclosure)
//        annotationView?.rightCalloutAccessoryView = butonPin
//        
//        return annotationView
//    }

extension DetailPage : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseID = "myAnnotation"
        var pinView = mapKit.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKMarkerAnnotationView
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            
            let butonPin = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = butonPin
            
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
}
