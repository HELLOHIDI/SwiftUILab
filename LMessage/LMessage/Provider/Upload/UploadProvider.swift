//
//  UploadProvider.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import Foundation
import FirebaseStorage

protocol UploadProviderType {
    func upload(path: String, data: Data, fileName: String) async throws -> URL
}

class UploadProvider: UploadProviderType {
    
    let storageRef = Storage.storage().reference()
    
    
    
    func upload(path: String, data: Data, fileName: String) async throws -> URL {
        let ref = storageRef.child(path).child(fileName)
        let _ = try await ref.putDataAsync(data) //upload를 진행하는 부분
        let url = try await ref.downloadURL() // 업로드된 url을 받아오는 부분
        return url
    }
}
