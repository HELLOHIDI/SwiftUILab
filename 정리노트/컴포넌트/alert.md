# alert

> 사실 이 친구는 modifier입니당~
> 

```swift
func alert<S, A, M, T>(
  _ title: S,
  isPresented: Binding<Bool>,
  presenting data: T?,
  @ViewBuilder actions: (T) -> A,
  @ViewBuilder message: (T) -> M
) -> some View where S : StringProtocol, A : View, M : View
```

### 필요한 인자값

- **`이름`** : 표시할 타이틀 값
- **`isPresented`**: 노출을 감지할 변수값 (@State 변수, alert창을 끌지 말지 정함)
- **`presenting` : 넘겨줄 데이터**
- **`Button` : alert 창 아래 버튼**
    - **.role : .cancel, .destructive 등등 (각각의 버튼 역할)**
- **`message` : 중간 소제목 부분**

```swift
.alert(
      "⚠️ 이슈 발생 ⚠️",
      isPresented: $isDisplayAlert,
      presenting: info
    ) { info in
      Button(role: .destructive) {
      } label: {
        Text("Delete \(info.name)")
      }
    } message: { info in
      Text(info.error)
    }
  }

```
<img width="182" alt="스크린샷 2024-06-27 오후 5 48 17" src="https://github.com/HELLOHIDI/SwiftUILab/assets/54922625/7ed6486e-444f-40ec-9b77-db20ea14abbb">
