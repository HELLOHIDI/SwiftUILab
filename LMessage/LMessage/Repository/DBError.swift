//
//  DBError.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
