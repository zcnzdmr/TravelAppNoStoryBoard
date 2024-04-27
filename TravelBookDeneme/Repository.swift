//
//  Repository.swift
//  TravelBookDeneme
//
//  Created by Özcan on 25.04.2024.
//

import Foundation
import CoreData
import RxSwift

class Repository {
    
    let context = appDelegate.persistentContainer.viewContext
    var travelList = BehaviorSubject<[Travel]>(value: [])
    
    func save(nameOfPlace:String,typeOfPlace:String,latitudeOfPlace:String,longitudeOfPlace:String) {
        
        let konum = Travel(context: context)
        
        konum.nameOfPlace = nameOfPlace
        konum.typeOfPalce = typeOfPlace
        konum.latitudeOfPlace = latitudeOfPlace
        konum.longitudeOfPlace = longitudeOfPlace
        
        appDelegate.saveContext()
        print("kayit oluştu")
    }
    
    func fetchFunc() {
        
        do {
            let list = try context.fetch(Travel.fetchRequest()) as? [Travel] ?? []
            travelList.onNext(list)
        }catch{
            print("Error \(error.localizedDescription)")
        }
        
    }

}

