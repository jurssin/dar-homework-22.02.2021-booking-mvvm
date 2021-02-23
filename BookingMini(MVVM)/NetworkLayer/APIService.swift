//
//  Parser.swift
//  BookingMini(MVVM)
//
//  Created by User on 2/21/21.
//  Copyright © 2021 Syrym Zhursin. All rights reserved.
//

import Foundation
import Moya

enum APIService {
    case getHotels
    case getDetailedHotel(id: String)
    case getHotelImage(id: String)
}
extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master")!
    }
    var path: String {
        switch self {
        
        case .getHotels:
            return "0777.json"
        case .getDetailedHotel(let id):
            return "\(id).json"
        case .getHotelImage(let id):
            return "\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDetailedHotel, .getHotelImage, .getHotels:
            return .get
        }

    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]

    }
}

