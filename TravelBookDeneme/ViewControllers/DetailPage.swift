//
//  DetailPage.swift
//  TravelBookDeneme
//
//  Created by Özcan Özdemir on 27.04.2024.
//

import UIKit
import MapKit


class DetailPage: UIViewController {
    
    var gelcekNesne = Travel()
    
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

//        if let x = gelcekNesne?.nameOfPlace ,
//            let y = gelcekNesne?.typeOfPalce ,
//           let e =  gelcekNesne?.latitudeOfPlace,
//           let b = gelcekNesne?.longitudeOfPlace {
//            
        name.text = gelcekNesne.nameOfPlace
        type.text = gelcekNesne.typeOfPalce

    }
    
    
    private func setUpUIObjects() {
        
        let screenWidth = view.frame.size.width
        view.backgroundColor = .systemBackground
        
        
        mapKit.frame = CGRect(x: 0, y: 310, width: screenWidth, height: 480)
        view.addSubview(mapKit)
        
        //mapkit konum gönderme ve point(pin) ekleme
        if let x = Double(gelcekNesne.latitudeOfPlace!), let y = Double(gelcekNesne.longitudeOfPlace!) {
            let konum = CLLocationCoordinate2D(latitude: x, longitude: y)
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let bolge = MKCoordinateRegion(center: konum, span: span)
            mapKit.setRegion(bolge, animated: true)
            
            let pin = MKPointAnnotation()
            pin.coordinate = konum
            pin.title = gelcekNesne.nameOfPlace
            pin.subtitle = gelcekNesne.typeOfPalce
            mapKit.addAnnotation(pin)
        }


        name.frame = CGRect(x: (screenWidth - 340) / 2, y: 150, width: 340, height: 30)
        name.layer.borderWidth = 0.4
        view.addSubview(name)
        
        type.frame = CGRect(x: (screenWidth - 340) / 2, y: 210, width: 340, height: 30)
        type.layer.borderWidth = 0.4
        view.addSubview(type)
        
    }
    
}
