//
//  MyProfileViewModel.swift
//  LMessage
//
//  Created by 류희재 on 8/15/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor // 메인액테어서 억세스 할 수 있는 키워드
class MyProfileViewModel: ObservableObject {
    
    @Published var userInfo: User?
    @Published var isPresentedDescEditView: Bool = false
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                await updateProfileImage(pickerItem: imageSelection)
            }
        }
    }
    
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
    
    func updateDescription(_ description: String) async {
        do {
            try await container.services.userService.updateUserDescription(userId: userId, description: description)
            userInfo?.description = description
        } catch {
            
        }
    }
    
    func updateProfileImage(pickerItem: PhotosPickerItem?) async {
        guard let pickerItem else { return }
        do {
            let datat = try await container.services.photoPickerService.loadTransferable(from: pickerItem)
            //TODO: storaget update
            //TODO: db update
        } catch {
            
        }
        
    }
}
