//
//  HomeModalDestination.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

/// 어떤 뷰를 모달로 띄울지 나타내는 enum 타입

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    
    var id: Int {
        hashValue
    }
}
