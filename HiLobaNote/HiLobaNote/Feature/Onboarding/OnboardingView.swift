//
//  ContentView.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/27/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var pathModel = PathModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        //TODO: 화면 전환 구현 필요
        
        NavigationStack(path: $pathModel.paths) {
            OnboardingContentView(onboardingViewModel: onboardingViewModel)
                .navigationDestination(
                    for: PathType.self,
                    destination: { pathType in
                        switch pathType {
                        case .homeView:
                            HomeView()
                                .navigationBarBackButtonHidden()
                        case .todoView:
                            TodoView()
                                .navigationBarBackButtonHidden()
                        case .memoView:
                            MemoView()
                                .navigationBarBackButtonHidden()
                        }
                    }
                )
        }
        .environmentObject(pathModel)
        
        //OnboardingContentView(onboardingViewModel: onboardingViewModel)
    }
}

// MARK: - 온보딩 컨텐츠 뷰

private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
            Spacer()
            StartButton()
        }
        .ignoresSafeArea()
    }
}

//MARK: - 온보딩 셀 리스트 뷰

private struct OnboardingCellListView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex: Int
    
    fileprivate init(
        onboardingViewModel: OnboardingViewModel,
        selectedIndex: Int = 0
    ) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(onboardingViewModel.onBoardingCotent.enumerated()), id: \.element) { index, onboardingContent in
                OnboardingCellView(onboardingContent: onboardingContent)
                    .tag(index)
                
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(
            width: 393, height: 852 / 1.5)
        .background(
            selectedIndex % 2 == 0
            ? Color.customSky
            : Color.customBackgroundGreen
        )
        .clipped()
    }
}

//MARK: - 온보딩 셀

private struct OnboardingCellView: View {
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }
    
    fileprivate var body: some View {
        VStack {
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                        .frame(height: 46)
                    
                    Text(onboardingContent.title)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text(onboardingContent.subTitle)
                        .font(.system(size: 16))
                    
                    Spacer()
                }
            }
            .background(Color.customWhite)
            .cornerRadius(0)
        }.shadow(radius: 10)
    }
}

//MARK: 시작하기 버튼

private struct StartButton: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        Button(
            action: { pathModel.paths.append(.homeView)},
            label: {
                HStack {
                    Text("시작하기")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.customGreen)
                    
                    Image("startHome")
                        .renderingMode(.template)
                        .foregroundColor(.customGreen)
                }
            }
        )
        .padding(.bottom, 50)
    }
}





struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
