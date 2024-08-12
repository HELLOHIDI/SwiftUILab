//
//  AuthenticationService.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation
import Combine

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum AuthenticationError: Error {
    case clientIDError
    case tokenError
    case invalidated
}

protocol AuthenticationServiceType {
    func checkAuthenticationState() -> String?
    func singInwithGoogle() -> AnyPublisher<User, ServiceError>
    func logout() -> AnyPublisher<Void, ServiceError>
}

class AuthenticationService: AuthenticationServiceType {
    func checkAuthenticationState() -> String? {
        // 현재 유저가 잇으면
        if let user = Auth.auth().currentUser {
            return user.uid // userID를 반환하고
        } else {
            return nil // 없으면 nil 값을 반환한다
        }
    }
    
    func singInwithGoogle() -> AnyPublisher<User, ServiceError> {
        Future { [weak self] promise in
            self?.signInWithGoogle { result in
                switch result {
                case let .success(user): // 구글로그인이 성공하면 completion을 퍼블리셔 형태로 바꾸어 성공값을 보낸다
                    promise(.success(user))
                case let .failure(error): // 실패하면 completion을 error값을 보낸다.
                    promise(.failure(.error(error)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Void, ServiceError> {
        Future { promise in
            do {
                try Auth.auth().signOut() // Firebase 내부적으로 선언되어 있는 로그아웃 메소드를 활용한다
                promise(.success(()))
            } catch {
                promise(.failure(.error(error)))
            }
        }.eraseToAnyPublisher()
    }
}

extension AuthenticationService {
    
    private func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        // Firebase clientID 받아오기
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthenticationError.clientIDError))
            return
        }
        
        // clientID를 바탕으로 Google Configuration object 생성
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        //제일 상위 뷰를 가져온다
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }
        
        
        // Configuration object로 Google 로그인 요청
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error  in
            if let error {
                completion(.failure(error))
                return
            }
            
            // 로그인 성공 시 result에서 user와 ID Token 추출
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthenticationError.tokenError))
                return
            }
            
            let accessToken = user.accessToken.tokenString // user에서 Access Token 추출
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken) // Token을 토대로 Credential(사용자 인증 정보) 생성
            
            
            self?.authenticateUserWithFirebase(credential: credential, completion: completion)
        }
    }
    
    // 생성한 Credential을 Firebase Auth 로그인 메서드에 전달
    private func authenticateUserWithFirebase(credential: AuthCredential, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in // 전달받은 Credential로 Firebase Auth에 로그인
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let result else {
                completion(.failure(AuthenticationError.invalidated))
                return
            }
            
            // 로그인에 성공 시 result에서 user를 받을 수 있는데
            // 해당 정보를 토대로 위에서 정의한 User Model 생성
            let firebaseUser = result.user
            let user: User = .init(
                id: firebaseUser.uid,
                name: firebaseUser.displayName ?? "",
                phoneNumber: firebaseUser.phoneNumber,
                profileURL: firebaseUser.photoURL?.absoluteString
            )
            
            completion(.success(user))
        }
    }
}

class StubAuthenticationService: AuthenticationServiceType {
    func checkAuthenticationState() -> String? {
        return nil
    }
    
    func singInwithGoogle() -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Void, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
}
