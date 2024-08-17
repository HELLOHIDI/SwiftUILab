//
//  ChatRoomService.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import Foundation
import Combine

protocol ChatRoomServiceType {
    func createChatRoomIfNeeded(myUserId: String, otherUserId: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError>
    func loadChatRoom(myUserId: String) -> AnyPublisher<[ChatRoom], ServiceError>
}

class ChatRoomService: ChatRoomServiceType {
    
    private let dbRepository: ChatRoomDBRepository
    
    init(dbRepository: ChatRoomDBRepository) {
        self.dbRepository = dbRepository
    }
    
    func createChatRoomIfNeeded(myUserId: String, otherUserId: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError> {
        dbRepository.getChatRoom(myUserId: myUserId, otherUserId: otherUserId) // 채팅방의 정보를 가져와서
            .mapError { ServiceError.error($0) }
            .flatMap { object in
                if let object {
                    return Just(object.toModel()).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
                } else { // 없다면
                    let newChatRoom: ChatRoom = .init(chatRoomId: UUID().uuidString, otherUserName: otherUserName, otherUserId: otherUserId) // 새로운 채팅방을 만들고
                    return self.addChatRoom(newChatRoom, to: myUserId) // 채팅방을 추가해줍니다
                }
            }.eraseToAnyPublisher()
    }
    
    func addChatRoom(_ chatRoom: ChatRoom, to myUserId: String) -> AnyPublisher<ChatRoom, ServiceError> { // 채팅방을 추가하는 부분
        dbRepository.addChatRoom(chatRoom.toObject(), myUserId: myUserId)
            .map { chatRoom }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func loadChatRoom(myUserId: String) -> AnyPublisher<[ChatRoom], ServiceError> { // 채팅방들을 불러오는 메소드
        dbRepository.laodChatRooms(myUserId: myUserId)
            .map { $0.map { $0.toModel()}}
            .mapError { ServiceError.error($0)}
            .eraseToAnyPublisher()
    }
}

class StubChatRoomService: ChatRoomServiceType {
    func createChatRoomIfNeeded(myUserId muUserId: String, otherUserId: String, otherUserName: String) -> AnyPublisher<ChatRoom, ServiceError> {
        Just(.stub1).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func loadChatRoom(myUserId: String) -> AnyPublisher<[ChatRoom], ServiceError> {
        Just([.stub1, .stub2]).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
}
