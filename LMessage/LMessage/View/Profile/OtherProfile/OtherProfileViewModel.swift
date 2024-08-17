//
//  OtherProfileViewModel.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor // 메인액테어서 억세스 할 수 있는 키워드
class OtherProfileViewModel: ObservableObject {
    
    @Published var userInfo: User?
    
    private let userId: String
    private var container: DIContainer
    
    init(container: DIContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userId: userId) {
            userInfo = user
        }
    }
}

