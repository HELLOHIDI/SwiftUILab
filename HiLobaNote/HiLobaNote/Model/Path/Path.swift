//
//  Path.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/27/24.
//

enum PathType: Hashable {
    case homeView
    case todoView
    case memoView(isCreateMode: Bool, memo: Memo?)
}
