//
//  HotelModel.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/21/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import Foundation

// MARK: - HotelElement
struct Hotel: Codable {
    let id: Int
    let name, address: String
    let stars: Int
    let distance: Double
    let suitesAvailability: String

    enum CodingKeys: String, CodingKey {
        case id, name, address, stars, distance
        case suitesAvailability = "suites_availability"
    }
}

typealias Hotels = [Hotel]

