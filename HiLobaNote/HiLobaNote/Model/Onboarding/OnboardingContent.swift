//
//  OnboardingContent.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/27/24.
//

import Foundation

struct OnboardingContent: Hashable {
    var imageFileName: String
    var title: String
    var subTitle: String
    
    init(imageFileName: String, title: String, subTitle: String) {
        self.imageFileName = imageFileName
        self.title = title
        self.subTitle = subTitle
    }
}
