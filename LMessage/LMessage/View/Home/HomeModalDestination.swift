//
//  HomeModalDestination.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    
    var id: Int {
        hashValue
    }
}
