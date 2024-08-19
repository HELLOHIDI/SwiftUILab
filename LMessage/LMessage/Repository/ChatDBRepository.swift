//
//  ChatDBRepository.swift
//  LMessage
//
//  Created by 류희재 on 8/19/24.
//

import Foundation
import Combine
import FirebaseDatabase

protocol ChatDBRepositoryType {
    func addChat(_ object: ChatObject, to chatRoomId: String) -> AnyPublisher<Void, DBError>
}

class ChatDBRepository: ChatDBRepositoryType {
    var db: DatabaseReference = Database.database().reference()
    
    func addChat(_ object: ChatObject, to chatRoomId: String) -> AnyPublisher<Void, DBError> {
        Just(object)
            .compactMap { try? JSONEncoder().encode($0)}
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed)}
            .flatMap { value in
                Future<Void,Error> { [weak self] promise in
                    self?.db.child(DBKey.Chats).child(chatRoomId).child(object.chatId).setValue(value) { error, _ in
                        if let error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .mapError { DBError.error($0) }
            .eraseToAnyPublisher()
    }
}
