//
//  LoginIntroView.swift
//  LMessenger
//
//

import SwiftUI

struct LoginIntroView: View {
    // 로그인 뷰를 띄울지에 대한 상태값
    @State private var isPresentedLoginView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Text("환영합니다.")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.bkText)
                Text("무료 메시지와 영상통화, 음성통화를 부담없이 즐겨보세요!")
                    .font(.system(size: 12))
                    .foregroundColor(.greyDeep)
                
                Spacer()
                
                Button {
                    // 버튼을 누르면 화면 이동 상태값을 변경하여서
                    isPresentedLoginView.toggle()
                } label: {
                    Text("로그인")
                }.buttonStyle(LoginButtonStyle(textColor: .lineApp))
            }
            // 다음뷰로 넘어갈 수 있도록 한다
            .navigationDestination(isPresented: $isPresentedLoginView) {
                LoginView()
            }
        }
    }
}

struct LoginIntroView_Previews: PreviewProvider {
    static var previews: some View {
        LoginIntroView()
    }
}
