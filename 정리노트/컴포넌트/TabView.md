# TabView

> **탭바의 항목들을 클릭해 뷰를 전환할 수 있게 해주는것**
> 
- **.tabItem을 이용해 TabBar를 구현해줍니다.**

```swift
import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      Text("The First Tab")
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("First")
        }
      Text("Another Tab")
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("Second")
        }
      Text("The Last Tab")
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("Third")
        }
    }
    .font(.headline)
  }
}
```

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/72606581-6bc2-40f1-a000-280f4c449173/8bc68192-d744-4d46-897c-bbfd86a5730a/Untitled.png)

### Modifier

- **`Badge` : 해당 탭바 버튼 항목에 뱃지**
    
    

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/72606581-6bc2-40f1-a000-280f4c449173/7a016b09-1f81-4053-84b9-99f121604a51/Untitled.png)

- **`selection / tag` :** 원하는 시작 뷰 지점이 있다면 아래와 같이 **selection과 tag로 구현**

```swift
import SwiftUI

struct ContentView: View {
  @State private var selection = 2
  
  var body: some View {
    TabView(selection: $selection) {
      Text("The First Tab")
        .badge(10)
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("First")
        }
        .tag(1)
      Text("Another Tab")
        .badge(20)
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("Second")
        }
        .tag(2)
      Text("The Last Tab")
        .badge(30)
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("Third")
        }
        .tag(3)
    }
    .font(.headline)
  }
}
```

[SwiftUI - TabView](https://green1229.tistory.com/234)
