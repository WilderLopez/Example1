//
//  WeatherNetworkLayer.swift
//  EvaluacionIOS
//
//  Created by Wilder Lopez on 12/23/22.
//

import Foundation
import SwiftyJSON
import MapKit

class WeatherNetworkLayer {
    
    public static let shared = WeatherNetworkLayer()
    
    private var baseUrl: String = "https://api.openweathermap.org/data/2.5/weather?"
    private var api_key : String = "78f4772ecac5ace56022016379caaa43"
    
    public func configure(apikey: String) {
        self.api_key = apikey
    }
    
    func getWeather(coordinate: CLLocationCoordinate2D, completion: @escaping (Result<Weather, Error>) -> Void) {
        
        let url = URL(string: "\(baseUrl)lat=\(String(format: "%.2f", coordinate.latitude))&lon=\(String(format: "%.2f", coordinate.longitude))&appid=\(api_key)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "com.wilderlopez.EvaluacionIOS", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error obteniendo datos del tiempo"])))
                return
            }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            }catch {
                completion(.failure(NSError(domain: "com.wilderlopez.EvaluacionIOS", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error obteniendo datos del tiempo"])))
                return
            }
            
//            let json = JSON(data)
//            let temperature = json["main"]["temp"].doubleValue
//            let humidity = json["main"]["humidity"].doubleValue
//            let windSpeed = json["wind"]["speed"].doubleValue
//            let weather = Weather(temperature: temperature, humidity: humidity, windSpeed: windSpeed)
            

        }
        task.resume()

    }

}


