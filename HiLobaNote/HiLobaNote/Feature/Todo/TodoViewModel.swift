//
//  TodoViewModel.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/27/24.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo]
    @Published var isEditTodoMode: Bool
    @Published var removeTodos: [Todo]
    @Published var isDisplayRemoveTodoAlert: Bool
    
    var removeTodosCount: Int {
        return removeTodos.count
    }
    var naigationBarRightBtnMode: NavigationBthType {
        isEditTodoMode ? .complete : .edit
    }
    
    init(
         todos: [Todo] = [],
         isEditTodoMode: Bool = false,
         removeTodos: [Todo] = [],
         isDisplayRemoveTodoAlert: Bool = false) {
        self.todos = todos
        self.isEditTodoMode = isEditTodoMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
    }
}
