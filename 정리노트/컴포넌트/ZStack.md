# ZStack

> 한 화면에서 뷰를 겹쳐 표현할 때 사용하는 컴포넌트
+) Z축 즉, 핸드폰 화면에 놓인 뷰 위에 다른 뷰를 쌓아가는 개념이라고 생각하시면 됩니다!
> 

### zIndex

> 더 많은 제어가 필요한 경우가 있다. 예를 들어 앱이 실행되는 동안 어떠한 뷰를 다른 뷰 뒤로 밀거나 탭할 때 특정 뷰를 앞으로 가져오고 싶을 때가 있다.
> 
- 기본 Z index는 0
- 다른 뷰의 위 또는 아래에 각각 배치하는 양수 or 음수 값을 제공할 수 있다.

```swift
ZStack {
    Rectangle()
        .fill(Color.green)
        .frame(width: 50, height: 50)
        .zIndex(1)
 
    Rectangle()
        .fill(Color.red)
        .frame(width: 100, height: 100)
}
```

이 코드 같은 경우는 빨강 아래 초록이 가겟쥬?

## cf) overlay

> view modifier로서, 부모 뷰에 종속된다
> 

### ZStack과의 차이점은?

<aside>
⭐ overlay로 구현한 코드는 부모의 크기에 종속되어서 만약 해당 텍스트를 사이즈를 키워드 부모의 크기 안에서만 커진다

하지만 ZStack로 구현한 코드는 각View가 독립적이기 때문에 Text의 크기가 커진 만큼 ZStack의 크기가 커진다.

</aside>

```swift
var body: some View {
    VStack {
        Rectangle()
            .fill(.yellow)
            .frame(width: 150,height: 150)
            .overlay(
                Text("bottom TabView")
                    .font(.system(size: 30))
                    .background(.blue), alignment: .bottom
            ).border(.red).padding(.bottom, 50)
        ZStack (alignment: .bottom) {
            Rectangle()
                .fill(.yellow)
                .frame(width: 150,height: 150)
            Text("bottom TabView")
                .font(.system(size: 30))
                .background(.brown)
        }.border(.red)
    }
}
```

![image](https://github.com/HELLOHIDI/SwiftUILab/assets/54922625/c5b21f50-5141-4574-a725-9e7a771108fc)


**[참고 사이트]**

https://seons-dev.tistory.com/entry/SwiftUI-ZStack-Spacer-offset-zIndex

https://kdjun97.github.io/swift/swiftui-zstack-overlay-background/
