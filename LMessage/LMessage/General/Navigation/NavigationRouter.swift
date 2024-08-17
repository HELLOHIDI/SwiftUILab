//
//  NavigationRouter.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import Foundation

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
