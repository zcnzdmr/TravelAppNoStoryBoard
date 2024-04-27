//
//  RegisterViewModel.swift
//  TravelBookDeneme
//
//  Created by Özcan on 25.04.2024.
//

import Foundation

class RegisterViewModel {
    
    var repoObject = Repository()
    
    func save(nameOfPlace:String,typeOfPlace:String,latitudeOfPlace:String,longitudeOfPlace:String) {
        repoObject.save(nameOfPlace: nameOfPlace, typeOfPlace: typeOfPlace, latitudeOfPlace: latitudeOfPlace, longitudeOfPlace: longitudeOfPlace)
    }
}
