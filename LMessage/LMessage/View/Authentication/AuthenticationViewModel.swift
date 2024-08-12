//
//  AuthenticationViewModel.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation
import Combine

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
        case logout
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLoading: Bool = false
    
    var userid: String?
    
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
            if let userId = container.services.authService.checkAuthenticationState() {
                self.userid = userId
                self.authenticationState = .authenticated
            }
        case .googleLogin:
            isLoading = true
            container.services.authService.singInwithGoogle()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userid = user.id
                    self?.authenticationState = .authenticated
                }
                .store(in: &subscriptions)
        case .logout:
            container.services.authService.logout()
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userid = nil
                }.store(in: &subscriptions)
        }
    }
}
