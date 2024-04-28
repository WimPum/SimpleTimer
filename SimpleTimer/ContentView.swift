//
//  ContentView.swift
//  AnalogTimer
//
//  Created by 虎澤謙 on 2024/03/31.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerCtrl: TimerLogic // タイマー
    //@FocusState private var isInputFocused: Bool //キーボードOn/Off
    @State private var isOpenPicker: Bool = false
    @AppStorage("DurationSec") private var DurationSec: Int = 20 // 残り時間（秒）設定用です
    @AppStorage("DurationMin") private var DurationMin: Int = 40 // 残り時間（分）
    var body: some View {
        VStack{
            ZStack(){ // タイマーの輪っか
                Circle()
                    .stroke(Color.green, style: StrokeStyle(lineWidth:10))
                    .scaledToFit()
                    .padding(10)
                Circle()
                    .trim(from: 0.0, to: timerCtrl.remainAmount)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .scaledToFit()
                    .padding(10)
                    .rotationEffect(.degrees(-90))
                Text("\(String(format: "%02d", Int(timerCtrl.cleanedTime / 60))):\(String(format: "%02d", Int(timerCtrl.cleanedTime) % 60))") // 数字でタイマー表示(分:秒)
                    .font(.system(size: CGFloat(100), weight: .light, design: .default))
                    .padding()
            }.frame(height: 380)
            HStack(){ // ボタンたち
                Spacer()
                Button(action: {
                    timerStartStop()
                }){
                    Text((timerCtrl.timer != nil) ? "Stop Timer" : "Start Timer")
                }
                Spacer()
                Button(action: {
                    timerReset()
                }){
                    Text("Reset Timer")//.border(Color.green, width: 2)
                }
                Spacer()
            }.frame(height: 20)
                .padding(.vertical)
            
            Form{
                Section{
                    Button {
                        if isOpenPicker == false{
                            withAnimation {
                                isOpenPicker.toggle()
                            }
                        }
                        else {
                            timerReset()
                        }
                    } label: {
                        HStack {
                            Text("開始")
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(String(format: "%02d", Int(timerCtrl.cleanedTime / 60))):\(String(format: "%02d", Int(timerCtrl.cleanedTime) % 60))")
                                .foregroundColor(isOpenPicker ? .blue : .secondary)
                        }
                    }
                    isOpenPicker ? PickerView(DurationMin: $DurationMin, DurationSec: $DurationSec) : nil
                }
            }
            //.scrollCBIfPossible()
            .foregroundStyle(.black)
            .pickerStyle(WheelPickerStyle())
            //.border(.black)
        }
        .onAppear(){
            timerCtrl.cleanedTime = Double(DurationMin * 60 + DurationSec)
            timerCtrl.maxValue = timerCtrl.cleanedTime
        }
    }
    
    func timerReset(){
        withAnimation {
            isOpenPicker = false
        }
        timerCtrl.stopTimer()
        timerCtrl.cleanedTime = Double(DurationMin * 60 + DurationSec)
        print("\(timerCtrl.cleanedTime)")
        timerCtrl.maxValue = timerCtrl.cleanedTime
        timerCtrl.remainAmount = 1 // リセットしたら満タン
    }
    
    func timerStartStop(){
        if (timerCtrl.timer == nil) {
            timerCtrl.startTimer(interval: 0.05) // intervalは秒？ 実質精度コントロール「
        } else {
            timerCtrl.stopTimer()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerLogic())
}
