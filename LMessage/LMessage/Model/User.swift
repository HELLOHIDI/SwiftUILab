//
//  User.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

struct User {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}

extension User {
    func toObject() -> UserObject {
        .init(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            profileURL: profileURL,
            description: description
        )
    }
}

extension User {
    static var stub1: User {
        .init(id: "user1_id", name: "김하늘")
    }
    
    static var stub2: User {
        .init(id: "user2_id", name: "김코랄")
    }
}
