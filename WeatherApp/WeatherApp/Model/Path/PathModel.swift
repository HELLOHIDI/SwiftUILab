//
//  PathModel.swift
//  WeatherApp
//
//  Created by 류희재 on 7/12/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
