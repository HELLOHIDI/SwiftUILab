//
//  DetailView.swift
//  WeatherApp
//
//  Created by 류희재 on 7/11/24.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var pathModel = PathModel()
    @EnvironmentObject private var viewModel: DetailViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                DetailMainView(viewModel: viewModel)
            }
            DetailBottomView()
        }
        .background(Image("backgroundIMG"))
    }
}

private struct DetailMainView: View {
    private let viewModel: DetailViewModel
    
    fileprivate init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 34)
            
            WeatherTemparatorView()
                .frame(width: 375, height: 212)
            
            Spacer()
                .frame(height: 44)
            
            HourlyTemparatorView(viewModel: viewModel)
                .frame(width: 335, height: 212)
            
            
            Spacer()
        }
    }
}

private struct WeatherTemparatorView: View {
    @EnvironmentObject private var viewModel: DetailViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.wetherData.city)
                .font(.system(size: 36, weight: .regular))
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 4)
            
            Text(viewModel.wetherData.temparature)
                .font(.system(size: 102, weight: .thin))
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 4)
            
            Text(viewModel.wetherData.weather)
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(.white)
            
            Spacer()
                .frame(height: 4)
            
            Text("최고:\(viewModel.wetherData.maxTemparature)°  최저:\(viewModel.wetherData.minTemparature)°")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

private struct HourlyTemparatorView: View {
    private let viewModel: DetailViewModel
    
    fileprivate init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Spacer()
                .frame(height: 11)
            
            Text("08:00~09:00에 강우 상태가, 18:00에 한\n때 흐린 상태가 예상됩니다.")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.white)
                .padding(.horizontal, 15)
            
            Spacer()
                .frame(height: 11)
            
            Rectangle()
                .frame(height: 0.2)
                .foregroundColor(.white)
                .padding(.leading, 14)
            
            Spacer()
                .frame(height: 14)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(viewModel.hourlyWeatherContent.enumerated()), id: \.element) { index, hourlyWeatherData in
                        HourlyTemparatorCellView(hourlyWeatherData: hourlyWeatherData)
                            .tag(index)
                        
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
        }
        .cornerRadius(15) // 원하는 반경으로 설정
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.white, lineWidth: 0.5)
        )
    }
}

private struct HourlyTemparatorCellView: View {
    private let hourlyWeatherData: HourlyWeatherModel
    
    fileprivate init(hourlyWeatherData: HourlyWeatherModel) {
        self.hourlyWeatherData = hourlyWeatherData
    }
    
    var body: some View {
        VStack {
            Text(hourlyWeatherData.time)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
            
            Image(hourlyWeatherData.icon)
                .resizable()
                .frame(width: 44, height: 44)
                .padding(.bottom, 14)
            
            Text(hourlyWeatherData.temparature)
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(width: 44, height: 122)
    }
}

private struct DetailBottomView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 0.4)
                .foregroundColor(.white)
            
            HStack {
                Button(
                    action: {},
                    label: {
                        Image("map")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .padding(.leading, 10)
                    }
                )
                
                Spacer()
                
                DetailBottomDotView()
                
                Spacer()
                
                Button(
                    action: {},
                    label: {
                        Image("list")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .padding(.trailing, 10)
                    }
                )
            }
        }
    }
}

private struct WeatherForecastView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                
            }
        }
    }
}

private struct DetailBottomDotView: View {
    var body: some View {
        HStack {
            Image("navigator")
                .resizable()
                .frame(width: 11, height: 11)
                .padding(.leading, 4)
            Image("dot")
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    DetailView()
        .environmentObject(PathModel())
}

