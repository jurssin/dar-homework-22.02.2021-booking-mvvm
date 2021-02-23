//
//  DetailedHotel.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/21/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import Foundation

struct DetailedHotel: Codable, Equatable {
    let id: Int
    let name, address: String
    let stars, distance: Double
    let image: String?
    let suitesAvailability: String
    let lat, lon: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance, image
        case suitesAvailability = "suites_availability"
        case lat, lon
    }
}
