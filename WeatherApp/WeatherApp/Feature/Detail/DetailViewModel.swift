//
//  DetailViewModel.swift
//  WeatherApp
//
//  Created by 류희재 on 7/12/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var hourlyWeatherContent: [HourlyWeatherModel] = [
        .init(time: "Now", icon: "cloudy", temparature: "21°"),
        .init(time: "Now", icon: "cloudy", temparature: "21°"),
        .init(time: "Now", icon: "cloudy", temparature: "21°"),
        .init(time: "Now", icon: "cloudy", temparature: "21°"),
        .init(time: "Now", icon: "cloudy", temparature: "21°"),
        .init(time: "Now", icon: "cloudy", temparature: "21°"),
        .init(time: "Now", icon: "cloudy", temparature: "21°"),
        .init(time: "Now", icon: "cloudy", temparature: "21°"),
        .init(time: "Now", icon: "cloudy", temparature: "21°")
    ]
    
    @Published var wetherData: WeatherModel
    
    init(wetherData: WeatherModel) {
        self.wetherData = wetherData
    }
}
