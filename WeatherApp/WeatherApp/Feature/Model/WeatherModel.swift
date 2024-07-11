//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by 류희재 on 7/11/24.
//

import Foundation

struct WeatherModel: Hashable {
    let city: String
    let weather: String
    let temparature: String
    let maxTemparature: Int
    let minTemparature: Int
    
    init(
        city: String,
        weather: String,
        temparature: String,
        maxTemparature: Int,
        minTemparature: Int
    ) {
        self.city = city
        self.weather = weather
        self.temparature = temparature
        self.maxTemparature = maxTemparature
        self.minTemparature = minTemparature
    }
}
