//
//  LMessageApp.swift
//  LMessage
//
//  Created by 류희재 on 8/6/24.
//

import SwiftUI

@main
struct LMessageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
//            LoginView()
            AuthenticationView(authViewModel: .init(container: container))
                .environmentObject(container)
        }
    }
}
