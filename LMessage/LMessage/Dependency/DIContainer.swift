//
//  DIContainer.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
