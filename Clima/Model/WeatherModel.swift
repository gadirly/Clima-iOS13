//
//  WeatherModel.swift
//  Clima
//
//  Created by Babek Gadirli on 02.12.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    let conditionID: Int
    let temprature: Double
    let cityName: String
    var tempratureString: String {
        return String(format: "%.1f", temprature)
    }
    
    var condition: String {
        switch conditionID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }

    }
}
