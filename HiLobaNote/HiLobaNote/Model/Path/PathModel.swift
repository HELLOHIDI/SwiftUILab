//
//  PathModel.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/27/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
