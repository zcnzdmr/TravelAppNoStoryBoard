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
    
    func save (nameOfPlace:String,
               typeOfPlace:String,
               latitudeOfPlace:String,
               longitudeOfPlace:String)
    {
        
        let konum = Travel(context: context)
        
        konum.nameOfPlace = nameOfPlace
        konum.typeOfPalce = typeOfPlace
        konum.latitudeOfPlace = latitudeOfPlace
        konum.longitudeOfPlace = longitudeOfPlace
        
        appDelegate.saveContext()
        
        //Farklı kaydetme yöntemi Core Data
//
//        let konum = NSEntityDescription.insertNewObject(forEntityName: "Travel", into: context)
//
//        
//        konum.setValue(nameOfPlace, forKey: "nameOfPlace")
//        konum.setValue(typeOfPlace, forKey: "typeOfPalce")
//        konum.setValue(latitudeOfPlace, forKey: "latitudeOfPlace")
//        konum.setValue(longitudeOfPlace, forKey: "longitudeOfPlace")
//        konum.setValue(UUID(),forKey:"id")  (bunu kullanmadık)
//        appDelegate.saveContext()
        
        print("kayit oluştu")
    }
    
    @objc func fetchFunc() {
        
        // Farklı bir CoreData veri okuma şekli
        let fetchNesnei = NSFetchRequest<NSFetchRequestResult>(entityName: "Travel")
        fetchNesnei.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchNesnei)
            if let list = results as? [Travel] {
                travelList.onNext(list)
            }
        }catch {
            print("hata")
        }
        
//        do {
//            let list = try context.fetch(Travel.fetchRequest()) as? [Travel] ?? []
//            travelList.onNext(list)
//        }catch{
//            print("Error \(error.localizedDescription)")
//        }
        
    }

}

