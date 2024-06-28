# ScrollView

> 스크롤이 가능한 컴포넌트
> 

### 필요한 인자값

- **`content`** : 스크롤뷰 안에 들어가는 내용들
- **`axes`**: 스크롤 방향
- **`showIndications` :** 인디케이터 바를 보여줄지 말지

```swift
struct ContentView: View {
  var body: some View {
    ScrollView(
      .vertical, 
      showsIndicators: true
    ) {
      VStack(alignment: .leading) {
        ForEach(0..<100) {
          Text("Row \($0)")
            .padding(.horizontal, 20)
        }
      }
    }
  }
}
```
