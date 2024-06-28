//
//  Todo.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/27/24.
//

import Foundation

struct Todo: Hashable {
    var title: String
    var time: Date
    var day: Date
    var selected: Bool
    
    var convertedDayAndTime: String {
        // 오늘 - 오후 03:00에 알림
        String("\(day.formattedDay) - \(time.formattedTime)에 알림")
    }
    
    init(title: String, time: Date, day: Date, selected: Bool) {
        self.title = title
        self.time = time
        self.day = day
        self.selected = selected
    }
}
