//
//  ContentView.swift
//  SwiftUILab
//
//  Created by 류희재 on 8/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                print("click me")
            } label: {
                Text("Google로 로그인")
            }.buttonStyle(
                SantaButtonStyle(.active)
            )
            
            Button {
                print("click me")
            } label: {
                Text("Google로 로그인")
            }.buttonStyle(
                SantaButtonStyle(.inActive)
            )
        }
    }
}

#Preview {
    ContentView()
}
