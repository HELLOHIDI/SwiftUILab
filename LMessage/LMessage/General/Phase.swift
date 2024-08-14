//
//  Phase.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

/// 서버통신에 따른 뷰의 상태를 나타내는 enum 타입
enum Phase {
    case notRequested
    case loading
    case success
    case fail
}
