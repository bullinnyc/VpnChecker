//
//  VpnCheckerApp.swift
//  VpnChecker
//
//  Created by Dmitry Kononchuk on 21.10.2024.
//

import SwiftUI

@main
struct VpnCheckerApp: App {
    // MARK: - Property Wrappers
    
    @StateObject private var vpnChecker = VpnChecker()
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vpnChecker)
        }
    }
}
