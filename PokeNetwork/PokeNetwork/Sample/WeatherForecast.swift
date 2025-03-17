//
//  WeatherForecast.swift
//  WeatherCast
//
//  Created by Lee Wonsun on 2/14/25.
//

import Foundation

// MARK: 5일간 예상 날씨
struct WeatherForecast: Decodable {
    let list: [ForecastList]
}

struct ForecastList: Decodable {
    let main: ForecastCondition
    let weather: [ForecastWeather]
    let date: String
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case date = "dt_txt"
        case rain
    }
}

struct ForecastCondition: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct ForecastWeather: Decodable {
    let icon: String
}

struct Rain: Decodable {
    let rain: Double
    
    enum CodingKeys: String, CodingKey {
        case rain = "3h"
    }
}
