//
//  HomeViewModel.swift
//  TravelBookDeneme
//
//  Created by Özcan on 25.04.2024.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    var travelList = BehaviorSubject<[Travel]>(value: [])
    var repoObject = Repository()
    
    init() {
        self.travelList = repoObject.travelList
        fetchFunc()
    }
    
    func fetchFunc() {
        repoObject.fetchFunc()
    }
    
}
