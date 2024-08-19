//
//  ChatDataModel.swift
//  LMessage
//
//  Created by 류희재 on 8/19/24.
//

import Foundation

struct ChatData: Hashable, Identifiable {
    var dateStr: String
    var chats: [Chat]
    var id: String { dateStr }
}
