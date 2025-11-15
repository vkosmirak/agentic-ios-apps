//
//  AgenticClockApp.swift
//  AgenticClock
//
//  Created by Volodymyr Kosmirak on 15.11.2025.
//

import SwiftUI
import Core

@main
struct AgenticClockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Logger.log("")
                }
        }
    }
}
