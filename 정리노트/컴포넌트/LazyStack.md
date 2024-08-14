## **기존 Stack Views**

> 일반적인 Stack Views에 해당하는 HStack, VStack, ZStack들은 화면에 display 될 때 **`Stack View 내부의 뷰들을 한 번에 loading 한다.`**
> 

⇒ 만약 데이터가 수 천개 또는 수 만개라면 이는 ContentView 로딩 초기에 성능 저하를 유발할것이다. 

### 장점

- 모든 내부의 뷰들의 크기와 모양을 알고 있기 때문에 뷰들을 한 번에 load 할 수 있다.
    
    ⇒ 이는 레이아웃을 빠르고 안정적으로 생성하는 데 도움을 준다.
    

### 단점

- 너무 많은 데이터가 있으면 ContentView 로딩 초기에 성능이 저하될 수 있다.

# Lazy Stack

> 스택 뷰가 화면에 렌더링해야 할 때까지 항목을 생성하지 않는다는 때이다.
⇒ view들을 한 번에 loading 하는 것이 아닌 스크롤 시 보이는 각각의 View를 생성한다!
> 

### 장점

- 뷰를 처음에 모두 렌더링할 필요 없는 경우 효율성을 위해서 lazy하게 사용가능하다.

### 단점

- 내부의 뷰가 보일 때만 위치와 크기를 계산하기 때문에 Stack view에 비해 레이아웃 정확성이 떨어진다.

## 공식 문서를 확인하면 일단 처음에는 Stack view를 사용하며, 성능적으로 개선이 필요할 시 Lazy Stack을 사용하는 것을 권장

https://medium.com/@hagjini0/swiftui-stack-views와-lazy-stack-차이점-a1c812ee7044

https://ios-development.tistory.com/1093

https://seons-dev.tistory.com/entry/SwiftUI-Lazy-VHStack
