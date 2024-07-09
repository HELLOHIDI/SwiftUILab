//
//  HomeView.swift
//  HiLobaNote
//
//  Created by 류희재 on 6/27/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var pathModel: PathModel
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            //탭뷰
            TabView(selection: $homeViewModel.selectedTab) {
                TodoListView()
                    .tabItem {
                        Image (
                            homeViewModel.selectedTab == .todoList
                            ? "todoIcon_selected"
                            : "todoIcon"
                        )
                    }
                    .tag(Tab.todoList)
                
                TodoListView()
                    .tabItem {
                        Image (
                            homeViewModel.selectedTab == .todoList
                            ? "todoIcon_selected"
                            : "todoIcon"
                        )
                    }
                    .tag(Tab.todoList)
                
                MemoListView()
                    .tabItem {
                        Image (
                            homeViewModel.selectedTab == .memo
                            ? "memoIcon_selected"
                            : "memoIcon"
                        )
                    }
                    .tag(Tab.memo)
                
                VoiceRecorderView()
                    .tabItem {
                        Image (
                            homeViewModel.selectedTab == .voiceRecorder
                            ? "recordIcon_selected"
                            : "recordIcon"
                        )
                    }
                    .tag(Tab.voiceRecorder)
                
                TimerView()
                    .tabItem {
                        Image (
                            homeViewModel.selectedTab == .timer
                            ? "timerIcon_selected"
                            : "timerIcon"
                        )
                    }
                    .tag(Tab.voiceRecorder)
                
                SettingView()
                    .tabItem {
                        Image (
                            homeViewModel.selectedTab == .setting
                            ? "settingIcon_selected"
                            : "settingIcon"
                        )
                    }
                    .tag(Tab.setting)
            }
            .environmentObject(homeViewModel)
            
            //구분선
            SeperatorLineView()
        }
    }
}

private struct SeperatorLineView: View {
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 10)
                .padding(.bottom, 60)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
        .environmentObject(MemoListViewModel())
}
