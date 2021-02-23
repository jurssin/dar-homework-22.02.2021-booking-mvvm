//
//  FavouriteHotelsViewModel.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/24/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import Foundation
class FavouriteHotelsViewModel {
    
    var favHotels = Favourites()
    
    init() {
        favHotels.hotelName = UserDefaults.standard.stringArray(forKey: "Hotel") ?? []
    }
}
