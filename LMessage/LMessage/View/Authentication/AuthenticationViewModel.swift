//
//  AuthenticationViewModel.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation
import Combine

/// 인증 여부
enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    //MARK: Action
    
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
            if let userId = container.services.authService.checkAuthenticationState() { //만약 userID가 존재한다면 인증이 되었다는 뜻
                self.userid = userId
                self.authenticationState = .authenticated
            }
        case .googleLogin:
            isLoading = true
            container.services.authService.singInwithGoogle()
            //TODO: db
                .flatMap { user in
                    self.container.services.userService.addUser(user)
                }
                .sink { [weak self] completion in
                    if case .failure = completion { // 만약 실패했다면
                        self?.isLoading = false // 로딩중을 꺼주고 (+ 나중에 토스트메세지로 어떤 에러인지를 알려줘도 좋겠죠!)
                    }
                } receiveValue: { [weak self] user in // user값을 받았다면
                    self?.isLoading = false // 로딩중을 꺼주고
                    self?.userid = user.id // userID를 받아온 뒤
                    self?.authenticationState = .authenticated // 인증상태를  인증 상태로 변경해준다
                }
                .store(in: &subscriptions)
        case .logout:
            container.services.authService.logout()
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in // 로그아웃이 성공했다면
                    self?.authenticationState = .unauthenticated // 인증상태를 비인증 상태로 변경해주고
                    self?.userid = nil // userID 값을 지워준다
                }.store(in: &subscriptions)
        }
    }
}
