# **TextField**

> Text의 입력을 읽어오기 위한 componen
> 

+) **`SecureField` : 비밀번호 같은 텍스트필드 가리기**

+) **`TextEditor` : 여러 줄 변경할 경우!**

### modifier

+) text를 저장할 수 있는 State값이 필요하다 → 각각의 textField마다

- **`placeholder`**: 첫 번째 인자 값
- **`textFieldStyle` : 텍스트 필드 스타일**

```swift
struct ContentView : View {
  @State var name: String = ""
  
  var body: some View {
    VStack {
      TextField("Enter your name", text: $name)
        .padding()
        .background(Color(uiColor: .secondarySystemBackground))
      
      Text("Hello \(name)")
    }
  }
}
```

## PlaceHolder의 속성을 바꾸고 싶다면?

> iOS 15이하라면 새롭게 만들어야 되지만 그 이후에는 prompt라는 것이 생김
> 

prompt → placeholder의 Text (title은 prompt가 없을 때 보임)

```swift
struct TextFieldTest: View {
    @State private var text: String = ""
    
    var body: some View {
        TextField(
            "타이틀",
            text: $text,
            prompt: Text("prompt").foregroundColor(.purple)
        )
            .foregroundColor(.green)
출처: https://nsios.tistory.com/187 [NamS의 iOS일기:티스토리]
```

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/72606581-6bc2-40f1-a000-280f4c449173/591d43e5-7b40-4d6a-8a2d-bca5eee1f902/Untitled.png)
