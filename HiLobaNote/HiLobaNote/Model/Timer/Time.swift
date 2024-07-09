//
//  Time.swift
//  HiLobaNote
//
//  Created by 류희재 on 7/5/24.
//

import Foundation

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    var convertSeconds: Int {
        return (hours * 3600) + (minutes * 60) + seconds
    }
    
    static func fromSeconds(_ seconds: Int) -> Time {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        return Time(hours: hours, minutes: minutes, seconds: remainingSeconds)
    }
}
