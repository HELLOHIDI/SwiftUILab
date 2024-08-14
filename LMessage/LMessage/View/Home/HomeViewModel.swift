//
//  HomeViewModel.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    //MARK: Action
    enum Action {
        case load
        case presentMyProfileView
        case presentOtherProfileView(String)
        case requestContact
    }
    
    @Published var myUser: User? // 내 정보
    @Published var users: [User] = [] // 다른 유저들 리스트
    @Published var phase: Phase = .notRequested // 서버통신에 따른 상태
    @Published var modalDestination: HomeModalDestination?
    
    private var userId: String // 유저 아이디
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .load: // 로드 시
            phase = .loading
            container.services.userService.getUser(userId: userId) // 유저의 정보를 가져온다
                .handleEvents(receiveOutput: { [weak self] user in // 유저정보가 잘 왔다면
                    self?.myUser = user // 유저 정보를 myUser에 저장해두고
                })
                .flatMap { user in
                    self.container.services.userService.loadUsers(id: user.id) // 다른 유저들의 정보를 요청한다
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail // 실패하면 phase를 fail로 바구고
                    }
                } receiveValue: { [weak self] users in // 성공했다면
                    self?.phase = .success // phase를 성공으로 바구고
                    self?.users = users // users의 값을 넣어준다
                }.store(in: &subscriptions)
            
        case .requestContact:
            container.services.contactService.fetchContacts() // 연락처와 연동해서 정보를 가져오면
                .flatMap { users in // 잘 가져오게되었다면
                    self.container.services.userService.addUserAfterContact(users: users) //파이어베이스의 해당 유저들을 등록을 시켜준다
                }
                //TODO: Load
                .flatMap { _ in // 파이어베이스에 잘 등록이 되었다면
                    self.container.services.userService.loadUsers(id: self.userId) // 해당 유저들을 파이어베이스에서 가져와서
                }
                // 아래는 loadUsers와 동일하다
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)
            
        case .presentMyProfileView: // 내 프로필 뷰를 모달로 띄우기 위해서 modalDestination 값을 변경
            modalDestination = .myProfile
            
        case let .presentOtherProfileView(userId): // 특정 다른 유저의 뷰를 모달로 띄우기 위해서 modalDestination 값을 변경
            modalDestination = .otherProfile(userId)
            
        }
    }
}
