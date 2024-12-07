//
//  SnackBar.swift
//  VpnChecker
//
//  Created by Dmitry Kononchuk on 24.11.2024.
//

import SwiftUI

struct SnackBar: ViewModifier {
    // MARK: - Public Properties
    
    let message: Binding<String?>
    let icon: String?
    
    // MARK: - Body Method
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            SnackBarView(message: message, icon: icon)
        }
    }
}

// MARK: - Ext. View

extension View {
    func snackBar(
        message: Binding<String?>,
        icon: String? = nil
    ) -> some View {
        modifier(SnackBar(message: message, icon: icon))
    }
}
