//
//  LoginView.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("로그인")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.bkText)
                    .padding(.top, 80)
                Text("아래 제공되는 서비스로 로그인을 해주세요")
                    .font(.system(size: 14))
                    .foregroundColor(.greyDeep)
            }
            .padding(.horizontal, 30)
            
            
            Spacer()
            
            Button {
                authViewModel.send(action: .googleLogin)
            } label: {
                Text("Google로 로그인")
            }.buttonStyle(LoginButtonStyle(textColor: .bkText, borderColor: .greyLight))
            
            Button {
                //TODO: 애플 로그인
            } label: {
                Text("Apple로 로그인")
            }.buttonStyle(LoginButtonStyle(textColor: .bkText, borderColor: .greyLight))
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("back")
                }
            }
        }
        .overlay {
            if authViewModel.isLoading {
                ProgressView()
            }
        }
    }
}

#Preview {
    LoginView()
}
