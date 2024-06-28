# Preview Crashed는 왜 일어날까
> 히로바노트 실습 중에 갑자기 아래와 같은 사진이 나와서 당황을 했다

<img width="182" alt="Preview Crashed" src="https://github.com/HELLOHIDI/SwiftUILab/assets/54922625/43e432ac-fbe8-45e3-8aff-13dac8d5dccb">

### 이유를 찾아보니 @EnviromentObject를 주입해주지 않아서였다

문제 코드는 아래와 같다

```swift
struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    blabla~
    
}

#Preview {
    TodoListView()
}

```

<aside>
⭐ `@**EnvironmentObject` 는 뷰에 선언만 하고 값을 할당하지 않는다. 그렇기 때문에 값을 할당해줘야함!**

</aside>

**해결코드: 단순히 View에 선언한** `@**EnvironmentObject` 를 Preview에도 할당해주면 된다!**

```swift
struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    blabla~
    
}

#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}
```

다른 상황들이 발생한다면 여기다가 추가할 예쩡~)
