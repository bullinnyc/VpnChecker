//
//  ContentView.swift
//  VpnChecker
//
//  Created by Dmitry Kononchuk on 21.10.2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Property Wrappers
    
    @EnvironmentObject private var vpnChecker: VpnChecker
    
    @State private var snackMessage: String?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
        }
        .snackBar(message: $snackMessage)
        .onReceive(vpnChecker.$isActive) { newValue in
            snackMessage = newValue ? "VPN Active" : "VPN Inactive"
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .environmentObject(VpnChecker())
}
