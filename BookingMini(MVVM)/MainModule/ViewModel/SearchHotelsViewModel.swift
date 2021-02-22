//
//  SearchHotelsViewModel.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/21/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import Foundation
import Moya

class SearchHotelsViewModel {
    
    let provider = MoyaProvider<APIService>()
    var hotels = [Hotel]()
    var dupHotels = [Hotel]()
    
    func getHotels(completion: @escaping () -> ()) {
        provider.request(.getHotels) { [weak self] (result) in
            
            switch result {
            case .success(let response):
                do {
                    let hotelsResponse = try JSONDecoder().decode(Hotels.self, from: response.data)
                    self?.hotels = hotelsResponse
                    completion()
                    print(self?.hotels ?? [])
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("failuer - \(error.localizedDescription)")
            }
            
        }
    }
    
    func sortByDistanceHotelList(completion: () -> ()) {
        self.hotels = hotels.sorted { (a, b) -> Bool in
            a.distance < b.distance
        }
        completion()
    }
    
    func sortByRoomsHotelList(completion: () -> ()) {
        self.hotels = hotels.sorted(by: { (a, b) -> Bool in
            a.suitesAvailability.count > b.suitesAvailability.count
        })
        completion()
    }
    
    func filterList(by searchText: String, completion: () -> ()) {
        self.hotels = searchText.isEmpty ? hotels : hotels.filter({ (hotel) -> Bool in
            return hotel.address.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        completion()
    }
}
