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
    
//    private func getDetailedHotel(id: String) {
//        provider.request(.getDetailedHotel(id: id)) { (result) in
//            switch result {
//
//            case .success(let response):
//                do {
//                    let response = try JSONDecoder().decode(DetailedHotel.self, from: response.data)
//                    print(response)
//
//                } catch let error {
//                    print("Decoding error: \(error.localizedDescription)")
//                }
//            case .failure(let error):
//                print("Can't reach to data \(error.localizedDescription)")
//            }
//        }
//    }
}
