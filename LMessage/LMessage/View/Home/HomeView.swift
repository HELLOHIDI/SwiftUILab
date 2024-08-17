//
//  HomeView.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            contentView
                .fullScreenCover(item: $viewModel.modalDestination) {
                    switch $0 {
                    case .myProfile:
                        MyProfileView(viewModel: .init(container: container, userId: viewModel.userId))
                    case let .otherProfile(userId):
                        OtherProfileView()
                    }
                }
        }
    }
    
    @ViewBuilder
    /*
     body 프로퍼티는 암시적으로 @ViewBuilder로 선언되어있기 때문.
     하지만 body외의 다른 프로퍼티나 메소드는
     기본적으로 ViewBuilder로 유추(infer)하지 않기 때문에 @ViewBuilder를 명시적으로 넣어줘야한다.
     */
    var contentView: some View {
        switch viewModel.phase { // 뷰의 상태에 따라서
        case .notRequested: // 아직 요청하지 않은 상태면
            PlaceholderView() // 기본 뷰를 넣어주고
                .onAppear {
                    viewModel.send(action: .load) // load 액션 실행
                }
        case .loading: // 로딩중이라면
            LoadingView() // 로딩뷰를 띄워주고
        case .success: // 성공했다면
            loadedView // 성공했을 때 나온 뷰에
                .toolbar { // 툴바에 이미지 및 버튼 추가
                    Image("bookmark")
                    Image("notifications")
                    Image("person_add")
                    Button {
                        //TODO:
                    } label: {
                        Image("settings")
                    }
                }
        case .fail: // 실패했다면
            ErrorView() // 에러뷰 반환
        }
    }
    
    var loadedView: some View {
        ScrollView {
            profileView
                .padding(.bottom, 30)
            searchButton
            
            HStack {
                Text("친구")
                    .font(.system(size: 14))
                    .foregroundColor(.bkText)
                Spacer()
            }
            .padding(.horizontal, 30)
            
            //TODO: 친구 목록
            if viewModel.users.isEmpty { // 친구 목록이 비어있다면
                Spacer(minLength: 89)
                emptyView // 엠티뷰를 띄워주고
            } else { // 아니라면
                LazyVStack { // LazyV(H)Stack은 테이블 view와 마찬가지로 뷰를 recycling할 가능성이 높습니다.
                    ForEach(viewModel.users, id: \.id) { user in
                        Button {
                            viewModel.send(action: .presentOtherProfileView(user.id)) // 버튼을 누르면 다른 유저의 프로필 뷰를 띄움
                        } label: {
                            HStack(spacing: 8) {
                                Image("person")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                Text(user.name)
                                    .font(.system(size: 12))
                                    .foregroundColor(.bkText)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
        }
    }
    
    var profileView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text(viewModel.myUser?.name ?? "이름")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.bkText)
                Text(viewModel.myUser?.description ?? "상태 메세지 입력")
                    .font(.system(size: 12))
                    .foregroundColor(.greyDeep)
            }
            
            Spacer()
            
            Image("person")
                .resizable()
                .frame(width: 52, height: 52)
                .clipShape(Circle())
        }
        .padding(.horizontal, 30)
        .onTapGesture { // 프로필뷰를 누르면 본인 프로필 뷰를 볼 수 있음
            viewModel.send(action: .presentMyProfileView)
        }
    }
    
    var searchButton: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 36)
                .background(Color.greyCool)
                .cornerRadius(5)
            
            HStack {
                Text("검색")
                    .font(.system(size: 12))
                    .foregroundColor(.greyLightVer2)
                Spacer()
            }
            .padding(.leading, 22)
        }
        .padding(.horizontal, 30)
    }
    
    var emptyView: some View {
        VStack {
            VStack(spacing: 3) {
                Text("친구를 추가해보세요.")
                    .foregroundColor(.bkText)
                Text("큐알코드나 검색을 이용해서 친구를 추가해보세요.")
                    .foregroundColor(.greyDeep)
            }
            .font(.system(size: 16))
            .padding(.bottom, 30)
            
            Button { // 친구추가 버튼을 누르면 친구 요청을 하는 메소드를 호출함 (자세한건 뷰모델에서!)
                viewModel.send(action: .requestContact)
            } label: {
                Text("친구추가")
                    .font(.system(size: 14))
                    .foregroundColor(.bkText)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 24)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.greyLight)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init(container: .init(services: StubService()), userId: "user_id"))
}
