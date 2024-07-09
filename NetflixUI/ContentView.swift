//
//  ContentView.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 10/06/24.
//

import SwiftUI

struct ContentView: View {
    var appData: AppData = .init()
    
    var body: some View {
        ZStack {
            /// First view after splash screen
            MainView()
            
            if appData.hideMainView {
                Rectangle()
                    .fill(.black)
                    .ignoresSafeArea()
            }
            
            ZStack {
                if appData.showProfileView {
                    ProfileView()
                }
            }
            
            if !appData.isSplashFinished {
                SplashScreen()
            }
        }
        .environment(appData)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
