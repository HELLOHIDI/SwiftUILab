//
//  NavigationDestination.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import Foundation

/// 네비게이션  도착지에 관련된  enum
enum NavigationDestination: Hashable {
    case chat(chatRoomId: String, myUserId: String, otherUserId: String)
    case search
}
