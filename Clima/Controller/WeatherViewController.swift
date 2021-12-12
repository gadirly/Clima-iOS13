//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTxtField: UITextField!
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    
    func weatherDidUpdate(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.conditionImageView.image = UIImage(systemName: weather.condition)
            self.cityLabel.text = weather.cityName
        }
        print(weather.tempratureString)
        print(weather.temprature)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTxtField.delegate = self
        
    }
    
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        
        searchTxtField.endEditing(true)
    }
    
    
    @IBAction func locationBtnPressed(_ sender: Any) {
        
        locationManager.requestLocation()
        
        
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTxtField.text {
            weatherManager.fethcWeather(cityName: city)
        }
        
        searchTxtField.text = ""
        searchTxtField.placeholder = "Search"
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTxtField.text != "" {
            return true
        }
        else {
            searchTxtField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTxtField.endEditing(true)
        return true
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lon = location.coordinate.longitude
            let lat = location.coordinate.latitude
            weatherManager.fetchWeather(lon: lon, lat: lat)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

