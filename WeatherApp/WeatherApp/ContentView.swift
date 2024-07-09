//
//  ContentView.swift
//  WeatherApp
//
//  Created by 류희재 on 7/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            MemoBtnView()
                .padding(.leading, 321) // MemoBtnView를 오른쪽으로 이동
            
            TitleView()
            
            Spacer()
                .frame(height: 8)
            
            SearchView(text: $searchText)
            
            // 날씨 리스트 뷰
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    // 날씨 리스트 셀뷰 여러 개
                    ForEach(0..<8) { _ in
                        WeatherListCellView()
                    }
                }
            }
        }
        .background(Color.black)
    }
}

private struct TitleView: View {
    fileprivate var body: some View {
        HStack{
            Text("날씨")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.leading, 20)
    }
}

private struct SearchView: View {
    @Binding var text: String
    
    fileprivate var body: some View {
        HStack {
            Image("search")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.vertical, 8)
                .padding(.leading, 8)
            
            TextField(
                "도시 또는 공항 검색",
                text: $text,
                prompt: Text("도시 또는 공항 검색")
                    .foregroundColor(.white)
                    .font(.system(size: 19, weight: .regular))
            )
            .padding(.leading, 8)
            .foregroundColor(.primary)
        }
        .background(Color.gray)
        .frame(width: 335, height: 40)
        .cornerRadius(10)
    }
}


private struct WeatherListCellView: View {
    fileprivate var body: some View {
        ZStack {
            Image("listImg")
            HStack {
                PlaceView()
                Spacer()
                TemparatorView()
            }
            
        }
        .frame(width: 335, height: 117)
    }
}

private struct PlaceView: View {
    fileprivate var body: some View {
        
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 10)
            
            Text("나의 위치")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 2)
            
            Text("의정부시")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
                .padding(.bottom, 23)
            
            Text("흐림")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding(.leading, 16)
    }
}

private struct TemparatorView: View {
    fileprivate var body: some View {
        VStack(alignment: .trailing) {
            Text("21°")
                .foregroundColor(.white)
                .font(.system(size: 52, weight: .light))
            
            Spacer()
                .frame(height: 23)
            
            HStack {
                Text("최고:29°")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                Text("최저:15°")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .padding(.trailing, 16)
    }
}

private struct MemoBtnView: View {
    fileprivate var body: some View {
        Button(
            action: {},
            label: {
                Image("menu")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        )
        .frame(width: 44, height: 44)
    }
}

#Preview {
    ContentView()
}

