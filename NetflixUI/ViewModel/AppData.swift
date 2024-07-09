//
//  AppData.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 10/06/24.
//

import SwiftUI

@Observable
class AppData {
    var isSplashFinished: Bool = false
    var activeTab: Tab = .home
    var hideMainView: Bool = false
    /// Profile Selection Properties
    var showProfileView: Bool = false
    var tabProfileRect: CGRect = .zero
    var watchingProfile: Profile?
    var animateProfile: Bool = false
    var fromTabBar: Bool = false
}
