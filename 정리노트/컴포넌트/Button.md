# Button

> 행동을 이니셜라이저해 컨트롤
> 

### 2가지 매개변수를 정의

- **`action` :**  이벤트가 발생했을 때의 처리
- **`label`**  : 버튼의 외형을 구분해주는 거고

```swift
var body: some View {
    VStack {
        Button(action: {
            print("Hello is HoonIOS")
        }, label: {
            Text("Hoons")
        })
    }
}
```

https://seons-dev.tistory.com/entry/Button버튼 →버튼에 다양한 사용 예시 코드 존재
