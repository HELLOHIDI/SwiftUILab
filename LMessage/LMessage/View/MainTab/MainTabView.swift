//
//  MainTabView.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var naivagationRouer: NavigationRouter
    @State private var selectedTab: MainTabType = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTabType.allCases, id: \.self) { tab in
                Group {
                    switch tab{
                    case .home:
                        HomeView(viewModel: .init(container: container, navigationRouter: naivagationRouer, userId: authViewModel.userid ?? ""))
                    case .chat:
                        ChatListView(viewModel: ChatListViewModel(container: container, userId: authViewModel.userid ?? ""))
                    case .phone:
                        Color.blackFix
                    }
                }
                .tabItem {
                    Label(tab.title, image: tab.imageName(selected: selectedTab == tab))
                }
                .tag(tab)
            }
        }
        .tint(.bkText)
    }
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.bkText)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static let container = DIContainer(services: StubService())
    
    static var previews: some View {
        MainTabView()
            .environmentObject(Self.container)
            .environmentObject(AuthenticationViewModel(container: Self.container))
    }
}
