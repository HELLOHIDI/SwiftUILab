//
//  ChatObject.swift
//  LMessage
//
//  Created by 류희재 on 8/19/24.
//

import Foundation

struct ChatObject: Codable {
    var chatId: String
    var userId: String
    var message: String?
    var photoURL: String?
    var date: TimeInterval
}

extension ChatObject {
    func toModel() -> Chat {
        .init(
            chatId: chatId,
            userId: userId,
            message: message,
            photoURL: photoURL,
            date: Date(timeIntervalSince1970: date)
        )
    }
}
