//
//  SettingView.swift
//  HiLobaNote
//
//  Created by 류희재 on 7/5/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            // 타이틀 뷰
            TitleView()
            
            Spacer()
                .frame(height: 35)
            
            // 총 탭 카운트 뷰
            
            TotalTabCountView()
            
            Spacer()
                .frame(height: 40)
            
            // 총 탭 무브 뷰
            
            TotalTabMoveView()
            
            Spacer()
        }
    }
}

//MARK: - 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("설정")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.customBlack)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 45)
    }
}

//MARK: - 전체 탭 설정된 카운트 뷰
private struct TotalTabCountView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        //가각 탭 카운트
        HStack {
            TabCountView(title: "TODO", count: homeViewModel.todosCount)
            Spacer()
                .frame(width: 30)
            TabCountView(title: "메모", count: homeViewModel.memosCount)
            Spacer()
                .frame(width: 30)
            TabCountView(title: "음성 메모", count: homeViewModel.voiceRecordersCount)
        }
    }
}

//MARK: - 각 탭 설정된 카운트 뷰
private struct TabCountView: View {
    private var title: String
    private var count: Int
    
    fileprivate init(title: String, count: Int) {
        self.title = title
        self.count = count
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.system(size: 24))
                .foregroundColor(.customBlack)
            
            Text("\(count)")
                .font(.system(size: 38, weight: .medium))
                .foregroundColor(.customBlack)
        }
    }
}
// MARK: - 총 탭 무브 뷰
private struct TotalTabMoveView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(Color.customGray1)
                .frame(height: 1)
            
            TabMoveView(
                title: "Todo List",
                tabAction: { 
                    homeViewModel.changeSelectedTab(.todoList)
                }
            )
            
            TabMoveView(
                title: "메모장",
                tabAction: {
                    homeViewModel.changeSelectedTab(.memo)
                }
            )
            
            TabMoveView(
                title: "음성메모",
                tabAction: {
                    homeViewModel.changeSelectedTab(.voiceRecorder)
                }
            )
            
            TabMoveView(
                title: "타이머",
                tabAction: {
                    homeViewModel.changeSelectedTab(.todoList)
                }
            )
            Rectangle()
                .fill(Color.customGray1)
                .frame(height: 1)
            
        }
    }
}

//MARK: - 각 탭 이동 뷰
private struct TabMoveView: View {
    private var title: String
    private var tabAction: () -> Void
    
    fileprivate init(title: String, tabAction: @escaping () -> Void) {
        self.title = title
        self.tabAction = tabAction
    }
    
    fileprivate var body: some View {
        Button(
            action: tabAction,
            label: {
                HStack {
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(.customBlack)
                    
                    Spacer()
                    
                    Image("arrowRight")
                }
            }
        )
        .padding(.all, 20)
    }
}


#Preview {
    SettingView()
}
