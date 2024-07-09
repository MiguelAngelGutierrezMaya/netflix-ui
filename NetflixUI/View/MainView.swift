//
//  MainView.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 10/06/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            /// Custom tab bar
            CustomTabBar()
        }
        .coordinateSpace(.named("MAINVIEW"))
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
