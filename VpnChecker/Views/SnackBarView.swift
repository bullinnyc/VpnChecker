//
//  SnackBarView.swift
//  VpnChecker
//
//  Created by Dmitry Kononchuk on 17.11.2024.
//

import SwiftUI

struct SnackBarView: View {
    // MARK: - Property Wrappers
    
    @State private var isShow = false
    @State private var timer: Timer?
    
    // MARK: - Private Properties
    
    private let message: Binding<String?>
    private let icon: String?
    
    // MARK: - Initializers
    
    init(message: Binding<String?>, icon: String? = nil) {
        self.message = message
        self.icon = icon
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if isShow {
                HStack(spacing: 16) {
                    if let icon = icon {
                        Image(systemName: icon)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 16, height: 16)
                    }
                    
                    Text(message.wrappedValue ?? "")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding()
                .frame(maxHeight: .infinity, alignment: .bottom)
                .transition(.move(edge: .bottom))
            }
        }
        .onChange(of: message.wrappedValue) { _, newValue in
            animateSnack(isShow: newValue != nil)
            startTimer()
        }
    }
    
    // MARK: - Private Methods
    
    private func animateSnack(isShow: Bool) {
        withAnimation(.bouncy.speed(0.8)) {
            self.isShow = isShow
        }
    }
    
    private func startTimer() {
        if let runningTimer = timer {
            runningTimer.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 4,
            repeats: false
        ) { _ in
            animateSnack(isShow: false)
            message.wrappedValue = nil
        }
    }
}

// MARK: - Preview

#Preview {
    SnackBarView(message: .constant("Some message"), icon: "xmark")
}
