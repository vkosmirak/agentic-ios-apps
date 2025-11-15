//
//  ContentView.swift
//  AgenticCompass
//
//  Created by Volodymyr Kosmirak on 15.11.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Compass")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .padding()
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
