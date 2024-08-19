//
//  ChatView.swift
//  LMessage
//
//  Created by 류희재 on 8/17/24.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var viewModel: ChatViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView {
            if viewModel.chatDataList.isEmpty {
                Color.chatBg
            } else {
                contentView
            }
        }
        .background(Color.chatBg)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(Color.chatBg, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    navigationRouter.pop()
                } label: {
                    Image("back")
                }
                
                Text(viewModel.otherUser?.name ?? "대화방이름")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.bkText)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image("search_chat")
                Image("bookmark")
                Image("settings")
            }
        }
        //        .toolbar {
        //            ToolbarItemGroup(placement: .key, content: <#T##() -> View#>) -> 이건 키보드 활성화할때만 나옴
        //        }
        .keyboardToolbar(height: 50) {
            HStack(spacing: 13) {
                Button {
                } label: {
                    Image("other_add")
                }
                Button {
                } label: {
                    Image("image_add")
                }
                Button {
                } label: {
                    Image("photo_camera")
                }
                
                TextField("", text: $viewModel.message)
                    .font(.system(size: 16))
                    .foregroundColor(.bkText)
                    .focused($isFocused)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 13)
                    .background(Color.greyCool)
                    .cornerRadius(20)
                
                Button {
                } label: {
                    Image("send")
                }
            }
            .padding(.horizontal, 27)
        }
        .onAppear {
            viewModel.send(action: .load)
        }
    }
    var contentView: some View {
        ForEach(viewModel.chatDataList) { chatData in
            Section {
                ForEach(chatData.chats) { chat in
                    ChatItemView(
                        message: chat.message ?? "",
                        direction: viewModel.getDirection(id: chat.userId),
                        date: chat.date
                    )
                }
            } header: {
                headerView(dateStr: chatData.dateStr)
            }
        }
    }
    
    func headerView(dateStr: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 76, height: 20)
                .background(Color.chatNotice)
                .cornerRadius(50)
            Text(dateStr)
                .font(.system(size: 10))
                .foregroundColor(.bgWh)
        }
    }
}

#Preview {
    NavigationStack {
        ChatView(viewModel: .init(
            container: DIContainer(services: StubService()),
            chatRoomId: "",
            myUserId: "",
            otherUserId: ""
        )
        )
    }
}
