//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by 류희재 on 7/11/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var weatherContent: [WeatherModel]
    
    init(
        weatherContent: [WeatherModel] = [
            .init(city: "서울", weather: "흐림", temparature: "21°", maxTemparature: 32, minTemparature: 1),
            .init(city: "경기도", weather: "맑음", temparature: "19°", maxTemparature: 29, minTemparature: 2),
            .init(city: "전라도", weather: "소나기", temparature: "30°", maxTemparature: 21, minTemparature: 4),
            .init(city: "의정부", weather: "눈", temparature: "23°", maxTemparature: 35, minTemparature: 5),
            .init(city: "여의도", weather: "맑음", temparature: "12°", maxTemparature: 23, minTemparature: 6),
            .init(city: "제주도", weather: "소나기", temparature: "9°", maxTemparature: 12, minTemparature: 10),
        ]
    ) {
        self.weatherContent = weatherContent
    }
}
