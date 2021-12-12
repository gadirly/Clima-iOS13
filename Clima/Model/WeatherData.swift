//
//  WeatherData.swift
//  Clima
//
//  Created by Babek Gadirli on 01.12.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let description: String
    let id: Int
}

struct Main: Decodable {
    let temp: Double
}

