//
//  TimerView.swift
//  HiLobaNote
//
//  Created by 류희재 on 7/5/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject var timerViewModel = TImerViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
       
        if timerViewModel.isDisplaySetTimeView {
            // 타이머 설정 뷰
            SetTimerView(timerViewModel: timerViewModel)
        } else {
            // 타이머 작동 뷰
            TimerOperationView(timerViewModel: timerViewModel)
        }
    }
}

//MARK: - 타이머 설정 뷰
private struct SetTimerView: View {
    @ObservedObject private var timerViewModel: TImerViewModel
    
    fileprivate init(timerViewModel: TImerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            // 타이틀
            TitleView()
            
            Spacer()
                .frame(height: 50)
            
            // 타이머 피커 뷰
            
            TimePickerView(timerViewModel: timerViewModel)
            
            Spacer()
                .frame(height: 50)
            
            // 설정하기 버튼 뷰
            
            TimerCreateBtnView(timerViewModel: timerViewModel)
            
            Spacer()
        }
    }
}

//MARK: 타이틀 뷰
private struct TitleView: View {
    var body: some View {
        HStack {
            Text("타이틀 뷰")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.customBlack)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}

//MARK: 타이머 피커 뷰
private struct TimePickerView: View {
    @ObservedObject private var timerViewModel: TImerViewModel
    
    fileprivate init(timerViewModel: TImerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
            
            HStack {
                Picker("Hour", selection: $timerViewModel.time.hours) {
                    ForEach(0..<24) { hour in
                        Text("\(hour)시")
                    }
                }
                
                Picker("Minute", selection: $timerViewModel.time.minutes) {
                    ForEach(0..<60) { minute in
                        Text("\(minute)분")
                    }
                }
                
                Picker("Second", selection: $timerViewModel.time.seconds) {
                    ForEach(0..<60) { second in
                        Text("\(second)초")
                    }
                }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
            
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
        }
    }
}

//MARK: 타이머 생성 버튼 뷰
private struct TimerCreateBtnView: View {
    @ObservedObject private var timerViewModel: TImerViewModel
    
    fileprivate init(timerViewModel: TImerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        Button(
            action: {
                timerViewModel.settingBtnTapped()
            },
            label:  {
                Text("설정하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.customGreen)
            }
        )
    }
}

//MARK: 타이머 작동 뷰

private struct TimerOperationView: View {
    @ObservedObject private var timerViewModel: TImerViewModel
    
    fileprivate init(timerViewModel: TImerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text("\(timerViewModel.timeRemaining.formattedTimeString)")
                        .font(.system(size: 28))
                        .foregroundColor(.customBlack)
                        .monospaced()
                    
                    HStack(alignment: .bottom) {
                        Image(systemName: "bell.fill")
                        
                        Text("\(timerViewModel.time.convertSeconds.formattedSettingTime)")
                            .font(.system(size: 16))
                            .foregroundColor(.customBlack)
                            .padding(.top, 10)
                    }
                    
                    Circle()
                        .stroke(Color.customOrange, lineWidth: 6)
                }
                
                Spacer()
                    .frame(height: 10)
                
                HStack {
                    Button(
                        action: {
                            timerViewModel.cancelBtnTapped()
                        },
                        label: {
                            Text("취소")
                                .font(.system(size: 16))
                                .foregroundColor(.customBlack)
                                .padding(.vertical, 22)
                                .padding(.horizontal, 22)
                                .background(
                                    Circle()
                                        .fill(Color.customGray2.opacity(0.3))
                                )
                        }
                    )
                }
                
                Spacer()
                
                Button(
                    action: {
                        timerViewModel.pauseOrRestartBtnTapped()
                    },
                    label: {
                        Text(timerViewModel.isPaused ? "계속진행" : "일시정지")
                            .font(.system(size: 14))
                            .foregroundColor(.customBlack)
                            .padding(.vertical, 25)
                            .padding(.horizontal, 7)
                            .background(
                                Circle()
                                    .fill(Color.customGray2.opacity(0.3))
                            )
                    }
                )
            }
        }
        .padding(.horizontal, 20)
    }
}




//MARK: - 타이머 설정 뷰

#Preview {
    TimerView()
}
