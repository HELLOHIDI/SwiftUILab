//
//  UserDBRepository.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation
import Combine
import FirebaseDatabase

protocol UserDBRepositoryType {
    func addUser(_ object: UserObject) -> AnyPublisher<Void, DBError> // 유저를 추가한다
    func getUser(userId: String) -> AnyPublisher<UserObject, DBError> // 유저 정보를 가져온다
    func loadUsers() -> AnyPublisher<[UserObject], DBError> // 유저들의 정보를 가져온다
    func addUserAfterContact(users: [UserObject]) -> AnyPublisher<Void, DBError> // 연락처 연동 후 유저들을 추가한다
}

class UserDBRepository: UserDBRepositoryType {
    
    var db: DatabaseReference = Database.database().reference()
    
    func addUser(_ object: UserObject) -> AnyPublisher<Void, DBError> {
        Just(object) // 주어진 UserObject를 발행하는 Publisher를 만듭니다.
            .compactMap { try? JSONEncoder().encode($0) } // JSON 데이터로 인코딩 실패하면 nil / 성공하면 data
        //        JSON 데이터를 파싱하여 Swift의 Dictionary나 Array 같은 JSON 호환 객체로 변환
            .compactMap { try? JSONSerialization.jsonObject(with: $0, options: .fragmentsAllowed) }
            .flatMap { value in
                Future<Void, Error> { [weak self] promise in // Users/userId/ 해당위치에 value값으로 넣어준다
                    self?.db.child(DBKey.Users).child(object.id).setValue(value) { error, _ in
                        if let error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .mapError { error in
                print("뭐가 문제임? 실패: \(error.localizedDescription)")
                return DBError.error(error)
            } // Future에서 발생한 Error를 DBError로 변
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) -> AnyPublisher<UserObject, DBError> {
        Future<Any?, DBError> { [weak self] promise in
            self?.db.child(DBKey.Users).child(userId).getData { error, snapshot in // Users/userId 위치에 있는 유저값을 가져오고
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull { //snapshot value 값이 비어있을 경우
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value)) // 성공하면 그 value를 반환한다
                }
            }
        }
        .flatMap { value in
            if let value {
                return Just(value) // 주어진 value를 발행하는 Publisher를 만듭니다.
                    .tryMap { try JSONSerialization.data(withJSONObject: $0)} // tryMap은 JSON 객체를 Data로 변환
                    .decode(type: UserObject.self, decoder: JSONDecoder()) // decode는 JSON 데이터를 UserObject로 디코딩합니다.
                    .mapError { DBError.error($0) }
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: .emptyValue).eraseToAnyPublisher() // 값이 비어있을 경우 emptyValue라는 에러를 반환한다
            }
        }.eraseToAnyPublisher()
    }
    
    func loadUsers() -> AnyPublisher<[UserObject], DBError> {
        Future<Any?,DBError> { [weak self] promise in
            self?.db.child(DBKey.Users).getData { error, snapshot in
                if let error {
                    promise(.failure(DBError.error(error)))
                } else if snapshot?.value is NSNull {
                    promise(.success(nil))
                } else {
                    promise(.success(snapshot?.value))
                }
            }
        }
        .flatMap { value in
            if let dic = value as? [String: [String:Any]] {
                return Just(dic)
                    .tryMap { try JSONSerialization.data(withJSONObject: $0)}
                    .decode(type: [String : UserObject].self, decoder: JSONDecoder())
                    .map { $0.values.map { $0 as UserObject } }
                    .mapError { DBError.error($0)}
                    .eraseToAnyPublisher()
            } else if value == nil {
                return Just([]).setFailureType(to: DBError.self).eraseToAnyPublisher()
            } else {
                return Fail(error: .invalidatedType).eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addUserAfterContact(users: [UserObject]) -> AnyPublisher<Void, DBError> {
        /*
         Users/
         user_id: [String: Any]
         user_id: [String: Any]
         user_id: [String: Any]
         */
        
        Publishers.Zip(users.publisher, users.publisher)
            .compactMap { origin, converted in
                if let converted = try? JSONEncoder().encode(converted) {
                    return (origin, converted)
                } else {
                    return nil
                }
            }
            .compactMap { origin, converted in
                if let converted = try? JSONSerialization.jsonObject(with: converted, options: .fragmentsAllowed) {
                    return (origin, converted)
                } else {
                    return nil
                }
            }
            .flatMap { origin, converted in
                Future<Void, Error> { [weak self] promise in
                    self?.db.child(DBKey.Users).child(origin.id).setValue(converted) { error, _ in
                        if let error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                }
            }
            .last()
            .mapError { .error($0)}
            .eraseToAnyPublisher()
    }
}
