//
//  TodoListViewModel.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/27/24.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] // 투두 배열
    @Published var isEditTodoMode: Bool // 편집 모드 여부
    @Published var removeTodos: [Todo] // 삭제할 투두 개수
    @Published var isDisplayRemoveTodoAlert: Bool // 삭제할 건지 묻는 alert 여부
    
    var removeTodosCount: Int { // 삭제할 투두개수
        return removeTodos.count
    }
    var naigationBarRightBtnMode: NavigationBtnType { // 네비게이션 모드
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

extension TodoListViewModel {
    func selectedBoxTapped(_ todo: Todo) { // 투
        if let index = todos.firstIndex(where: { $0 == todo}) {
            todos[index].selected.toggle()
        }
    }
    
    func addTodo(_ todo: Todo) { // 투두 추가
        todos.append(todo)
    }
    
    func navigationRightBtnTapped() {
        if isEditTodoMode {
            if removeTodos.isEmpty {
                isEditTodoMode = false
            } else {
                
            }
        } else {
            isEditTodoMode = true
        }
    }
    
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) { // alert창을 띄울건지 여부 설정
        isDisplayRemoveTodoAlert = isDisplay
    }
    
    func todoRemoveSelectedBoxTapped(_ todo: Todo) {
        if let index = removeTodos.firstIndex(of: todo) {
            removeTodos.remove(at: index)
        } else {
            removeTodos.append(todo)
        }
    }
    
    func removeBtnTapped() { // 투두 삭제
        todos.removeAll { todo in
            removeTodos.contains(todo)
        }
        removeTodos.removeAll()
        isEditTodoMode = false
    }
}

