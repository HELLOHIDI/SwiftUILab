//
//  NavigationRoutingView.swift
//  LMessage
//
//  Created by 류희재 on 8/18/24.
//

import SwiftUI

// 도착지에 맞게 분기처리를 도와주는 뷰
struct NavigationRoutingView: View {
    @State var destination: NavigationDestination
    var body: some View {
        switch destination {
        case .chat:
            ChatView()
        case .search:
            SearchView()
        }
    }
}
