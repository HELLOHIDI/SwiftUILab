//
//  AuthenticationView.swift
//  LMessage
//
//  Created by 류희재 on 8/6/24.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var authViewModel: AuthenticationViewModel
    @StateObject var navigationRouter: NavigationRouter
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                MainTabView()
                    .environmentObject(authViewModel)
                    .environmentObject(navigationRouter)
            }
        }
        .onAppear {
//            authViewModel.send(action: .checkAuthenticationState)
            authViewModel.send(action: .logout)
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(authViewModel: .init(container: .init(services: StubService())), navigationRouter: .init())
    }
}
