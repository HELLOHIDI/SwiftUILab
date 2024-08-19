//
//  Chat.swift
//  LMessage
//
//  Created by 류희재 on 8/19/24.
//

import Foundation

struct Chat: Hashable, Identifiable {
    var chatId: String
    var userId: String
    var message: String?
    var photoURL: String?
    var date: Date
    var id: String { chatId }
}

extension Chat {
    func toObject() -> ChatObject {
        .init(
            chatId: chatId,
            userId: userId,
            message: message,
            photoURL: photoURL,
            date: date.timeIntervalSince1970
        )
    }
}
