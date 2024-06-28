//
//  MemoViewModel.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/28/24.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}
