//
//  MainTabType.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

/// 메인 탭의 타입
enum MainTabType: String, CaseIterable { // For Each를 위해서 CaseIterable 프로토콜 채택
    case home
    case chat
    case phone
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .chat:
            return "대화"
        case .phone:
            return "통화"
        }
    }
    
    func imageName(selected: Bool) -> String {
        selected ? "\(rawValue)_fill" : rawValue
    }
}
