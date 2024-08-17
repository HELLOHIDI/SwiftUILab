//
//  NavigationRoutingView.swift
//  LMessage
//
//  Created by 류희재 on 8/18/24.
//

import SwiftUI

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
