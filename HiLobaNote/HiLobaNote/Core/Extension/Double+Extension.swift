//
//  Double+Extension.swift
//  HiLobaNote
//
//  Created by 류희재 on 7/2/24.
//

import Foundation

extension Double {
    var formattedTimeInterval: String {
        let totalSeconds = Int(self)
        let seconds = totalSeconds % 60
        let minute = (totalSeconds / 60) % 60
        
        return String(format: "%02d:%02d", minute, seconds)
    }
}
