//
//  Publisher.swift
//  VpnChecker
//
//  Created by Dmitry Kononchuk on 21.10.2024.
//

import UIKit

final class Publisher {
    // MARK: - Public Properties
    
    // Publishers.
    static let didBecomeActiveNotification = NotificationCenter.default
        .publisher(for: UIApplication.didBecomeActiveNotification)
}
