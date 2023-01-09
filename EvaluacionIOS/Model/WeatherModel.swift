//
//  WeatherModel.swift
//  EvaluacionIOS
//
//  Created by Wilder Lopez on 12/23/22.
//

import Foundation

struct Weather : Codable {
    let location: Location?
    let weather: [WeatherCondition]?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let date: Date?
    let sys: Sys?
    let timeZone: Int?
    let id: Int?
    let name: String?
}

struct Location : Codable {
    let longitude: Double?
    let latitude: Double?
}

struct WeatherCondition : Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main : Codable {
    let temp: Double?
}

struct Wind : Codable {
    let speed: Double?
    let degree: Int?
    let gust: Double?
}

struct Rain : Codable {
    let oneHour: Double?
}

struct Clouds : Codable {
    let all: Int?
}

struct Sys : Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Date?
    let sunset: Date?
}
