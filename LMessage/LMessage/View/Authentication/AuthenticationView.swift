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
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .unauthenticated:
                //TODO: loginView
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                //TODO: mainTabView
                MainTabView()
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(authViewModel: .init(container: .init(services: StubService())))
    }
}
