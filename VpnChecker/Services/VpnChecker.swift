//
//  VpnChecker.swift
//  VpnChecker
//
//  Created by Dmitry Kononchuk on 21.10.2024.
//

import Foundation
import Combine

final class VpnChecker: ObservableObject {
    // MARK: - Private Properties
    
    @Published private(set) var isActive = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    private static let protocolIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]
    
    // MARK: - Initializers
    
    init() {
        Publisher.didBecomeActiveNotification
            .sink { [weak self] _ in
                guard let self else { return }
                
                self.isActive = self.isVpnActive()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Deinitializers
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK: - Private Methods
    
    private func isVpnActive() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings() else {
            return false
        }
        
        let proxySettingsDict = proxySettings
            .takeRetainedValue() as NSDictionary
        
        guard let keys = proxySettingsDict["__SCOPED__"] as? NSDictionary,
              let allKeys = keys.allKeys as? [String]
        else { return false }
        
        for key in allKeys {
            for identifier in Self.protocolIdentifiers where key.starts(
                with: identifier
            ) {
                return true
            }
        }
        
        return false
    }
}
