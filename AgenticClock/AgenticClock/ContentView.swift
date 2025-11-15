//
//  ContentView.swift
//  AgenticClock
//
//  Created by Volodymyr Kosmirak on 15.11.2025.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var textContent = "Hello, world!"
    @State private var currentTime = Date()

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20) {
            // Live Clock at the top
            Text(currentTime, style: .time)
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .monospacedDigit()
                .padding()

            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            TextField("Enter text", text: $textContent)
                .textFieldStyle(.roundedBorder)
                .padding()
            Text(textContent)
                .padding()
        }
        .padding()
        .onReceive(timer) { _ in
            currentTime = Date()
        }
    }
}

#Preview {
    ContentView()
}
