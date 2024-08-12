//
//  Services.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
    
}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    
    init() {
        self.authService = AuthenticationService()
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
}
