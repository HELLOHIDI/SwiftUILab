# HStack

> **내부에 선언된 View들을 Leading에서 Trailing으로 배치한다**
> 

```swift
struct ContentView: View {
    var body: some View {
        HStack {
            Text("소들")
                .background(.red)
            Text("추운 소들")
                .background(.yello)
            Text("춥고 배고픈 소들")
                .background(.blue)
        }
    }
}
```

# **VStack**

> **내부에 선언된 View들을 Top에서 Bottom으로 배치한다**
> 

```swift
struct ContentView: View {
    var body: some View {
       VStack {
            Text("소들")
                .background(.red)
            Text("추운 소들")
                .background(.yello)
            Text("춥고 배고픈 소들")
                .background(.blue)
        }
    }
}
```

### Modifier

- **`.frame` : Stack의 Frame을 직접 지정해주고 싶을 경우**
- **`.alignment` : Stack의 종류에 따라 정렬 방식 설정**
- **`.spacing` : 뷰 간격 간의 여백을 지정**
