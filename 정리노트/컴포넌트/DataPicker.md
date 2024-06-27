# DataPicker

> 사용자가 특정 날짜를 설정할 수 있도록 하는 컴포넌트
> 

### 필요한 인자값

- **`이름`** : DataPicker의 이름
- **`selection`**: 선택한 날짜를 저장할 프로퍼티 (**`@State 프로퍼티`)**
- **`displayedComponents` :** 날짜, 시간을 표시할건지 선택

```swift
struct ContentView: View {
  @State var date = Date()
  
  var body: some View {
    DatePicker(
      "DatePicker",
      selection: $date,
      displayedComponents: [.date]
    )
  }
}
```

### .datePickerStyle

- **`compact`** :  간결한 ui 제공
- **`graphical`**: 달력형식
- **`wheel`** : 일반적인 피커 방식의 휠 형식
- automatic : 시스템이 적합하다고 생각하는 ui 제공

### Date 제한 주기

> DataPicker의 생성자는 **`in 파라미터`**를 통해서 날짜를 제한할 수 있다.
> 

**`ClosedRange<Date>` 타입으로 정할 수 있음.**

```swift
var dateRange: ClosedRange<Date> {
    let min = Calendar.current.date(
      byAdding: .year,
      value: -10, 
      to: date
    )!
    let max = Calendar.current.date(
      byAdding: .year,
      value: 10,
      to: date
    )!
    return min...max
  }
```

**참고 사이트**

https://ios-development.tistory.com/1089
