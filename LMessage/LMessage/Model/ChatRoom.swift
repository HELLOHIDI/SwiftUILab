//
//  ChatRoom.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import Foundation

struct ChatRoom: Hashable {
    var chatRoomId: String
    var lastMessage: String?
    var otherUserName: String
    var otherUserId: String
}

extension ChatRoom {
    func toObject() -> ChatRoomObject {
        .init(
            chatRoomId: chatRoomId,
            lastMessage: lastMessage,
            otherUserName: otherUserName,
            otherUserId: otherUserId
        )
    }
}

extension ChatRoom {
    static var stub1: ChatRoom {
        .init(chatRoomId: "chatRoom1_id", otherUserName: "김하늘", otherUserId: "user_id")
    }
    
    static var stub2: ChatRoom {
        .init(chatRoomId: "chatRoom2_id", otherUserName: "김하늘", otherUserId: "user2_id")
    }
}
