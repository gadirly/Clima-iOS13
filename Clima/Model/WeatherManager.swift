//
//  WeatherManager.swift
//  Clima
//
//  Created by Babek Gadirli on 29.11.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func weatherDidUpdate(weather: WeatherModel)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=8fec3f87c10ca3ab72ffe8f91d231ac6&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fethcWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(lon: CLLocationDegrees, lat: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    
                    return
                }
                if let safeData = data {
                    
                    if let weather = parseJson(weatherData: safeData){
                        self.delegate?.weatherDidUpdate(weather: weather)
                    }
                    
                }
              
              
                
            }
            
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let weatherModel = WeatherModel(conditionID: id, temprature: temp, cityName: name)
            return weatherModel
        }
        catch {
            print(error)
            return nil
        }
    }
    
    
    
    
    
}
