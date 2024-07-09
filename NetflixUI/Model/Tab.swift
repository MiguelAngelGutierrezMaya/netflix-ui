//
//  Tab.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 10/06/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case new = "New & Hot"
    case account = "My netflix"
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .new:
            return "play.rectangle.on.rectangle"
        case .account:
            return "Profile"
        }
    }
}
