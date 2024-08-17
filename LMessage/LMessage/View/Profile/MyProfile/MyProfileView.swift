//
//  MyProfileView.swift
//  LMessage
//
//  Created by 류희재 on 8/12/24.
//

import SwiftUI
import PhotosUI

struct MyProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: MyProfileViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("profile_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(edges: .vertical)
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    profileView
                        .padding(.bottom, 16)
                    
                    nameView
                        .padding(.bottom, 26)
                    
                    descriptionView
                    
                    Spacer()
                    
                    menuView
                        .padding(.bottom, 58)
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                    } label: {
                        Image("close")
                    }
                }
            }
            .task {
                await viewModel.getUser()
            }
        }
    }
    
    var profileView: some View {
        PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
            URLImageView(urlString: viewModel.userInfo?.profileURL)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
//            AsyncImage(url: URL(string: viewModel.userInfo?.profileURL ?? "")) { image in
//                image.resizable()
//            } placeholder: {
//                Image("person")
//                    .resizable()
//            }
//            .frame(width: 80, height: 80)
//            .clipShape(Circle())
        }
    }
    
    var nameView: some View {
        Text(viewModel.userInfo?.name ?? "이름")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.bgWh)
    }
    
    var descriptionView: some View {
        Button {
            
        } label: {
            Text(viewModel.userInfo?.description ?? "상태메세지를 입력해주세요.")
                .font(.system(size: 14))
                .foregroundColor(.bgWh)
        }
        .sheet(isPresented: $viewModel.isPresentedDescEditView) {
            MyProfileDescEditView(description: viewModel.userInfo?.description ?? "") { willBeDesc in
                Task {
                    await viewModel.updateDescription(willBeDesc)
                }
            }
        }
    }
    
    var menuView: some View {
        HStack(alignment: .top, spacing: 27) {
            ForEach(MyProfileMenuType.allCases, id: \.self) { menu in
                Button {
                } label: {
                    VStack(alignment: .center) {
                        Image(menu.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(menu.description)
                            .font(.system(size: 10))
                            .foregroundColor(.bgWh)
                    }
                }
            }
        }
    }
}

#Preview {
    MyProfileView(
        viewModel: .init(
            container: DIContainer(services: StubService()),
            userId: ""
        )
    )
}
