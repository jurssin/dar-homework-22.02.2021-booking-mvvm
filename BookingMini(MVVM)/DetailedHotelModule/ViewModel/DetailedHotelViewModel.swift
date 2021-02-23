//
//  DetailedHotelViewModel.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/22/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import Foundation
import UIKit
import Moya

class DetailedHotelViewModel {
    
    let provider = MoyaProvider<APIService>()
    var detailedHotel: DetailedHotel?
    var favHotels: [String] = []
    
    public func getDetailedHotels(id: Int, completion: @escaping (DetailedHotel?) -> ()) {
        provider.request(.getDetailedHotel(id: String(id))) { [weak self] (result) in
            switch result {
            case .success(let response):
                do {
                    let detailedHotelResponse = try JSONDecoder().decode(DetailedHotel.self, from: response.data)
                    self?.detailedHotel = detailedHotelResponse
                    //print(self?.detailedHotel ?? "")
                    
                    completion(self?.detailedHotel ?? nil)
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func getImage(id: String, completion: @escaping (Data) -> ()) {
        provider.request(.getHotelImage(id: (id))) { (result) in
            switch result {
            case.success(let response):
                completion(response.data)
            case.failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
