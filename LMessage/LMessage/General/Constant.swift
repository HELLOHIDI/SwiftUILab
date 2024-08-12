//
//  Constant.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

typealias DBKey = Constant.DBKey

enum Constant {}

extension Constant {
    struct DBKey {
        static let Users = "Users"
        static let ChatRooms = "ChatRooms"
        static let Chats = "Chats"
    }
}
