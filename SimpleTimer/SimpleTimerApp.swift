//
//  SimpleTimerApp.swift
//  SimpleTimer
//
//  Created by 虎澤謙 on 2024/04/19.
//

import SwiftUI

@main
struct SimpleTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TimerLogic())
        }
    }
}
