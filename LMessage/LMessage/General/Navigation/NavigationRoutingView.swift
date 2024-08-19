//
//  NavigationRoutingView.swift
//  LMessage
//
//  Created by 류희재 on 8/18/24.
//

import SwiftUI

// 도착지에 맞게 분기처리를 도와주는 ㅂ
struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    var body: some View {
        switch destination {
        case let .chat(chatRoomId, myUserId, otherUserId):
            ChatView(viewModel: .init(container: container, chatRoomId: chatRoomId, myUserId: myUserId, otherUserId: otherUserId))
        case .search:
            SearchView()
        }
    }
}
