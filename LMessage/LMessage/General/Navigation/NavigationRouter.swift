//
//  NavigationRouter.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import Foundation

/// 네비게이션을 관리하는 부분
class NavigationRouter: ObservableObject {
    @Published var destination: [NavigationDestination] = []
    
    func push(to view: NavigationDestination) {
        destination.append(view)
    }
    
    func pop() {
        _ = destination.popLast()
    }
    
    func popToRootView() {
        destination = []
    }
    
}
