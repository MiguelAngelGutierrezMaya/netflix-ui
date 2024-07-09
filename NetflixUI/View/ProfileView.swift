//
//  ProfileView.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 23/06/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AppData.self) private var appData
    
    /// View properties
    @State private var animateToCenter = false
    @State private var animateToMainView = false
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack {
            Button("Edit") {
                
            }
            .frame(
                maxWidth: .infinity,
                alignment: .trailing
            )
            .overlay {
                Text("Who's watching?")
                    .font(.title3.bold())
            }
            .overlay(alignment: .leading) {
                if appData.fromTabBar {
                    Button(action: {
                        withAnimation(
                            .snappy(
                                duration: 0.3,
                                extraBounce: 0
                            )
                        ) {
                            appData.showProfileView = false
                            appData.hideMainView = false
                            appData.fromTabBar = true
                            
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .contentShape(.rect)
                    })
                }
            }
            
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(
                        .fixed(100),
                        spacing: 25
                    ),
                    count: 2
                )
            ) {
                ForEach(mockProfiles) { profile in
                    ProfileCardView(
                        profile: profile,
                        animateToCenter: animateToCenter
                    )
                }
                /// Add Button
                Button(action: {}, label: {
                    ZStack {
                        RoundedRectangle(
                            cornerRadius: 10
                        )
                        .stroke(
                            .white.opacity(0.8),
                            lineWidth: 0.8
                        )
                        
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .frame(
                        width: 100,
                        height: 100
                    )
                    .contentShape(.rect)
                })
            }
            .frame(maxHeight: .infinity)
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(animateToCenter ? 0 : 1)
        .background(.black)
        .opacity(animateToMainView ? 0 : 1)
        .overlayPreferenceValue(RectAnchorKey.self) { value in
            AnimationLayerView(
                value: value,
                progress: progress,
                animateToCenter: animateToCenter,
                animateToMainView: animateToMainView,
                setAnimation: { animation in
                    animateToCenter = animation
                }) { animation, progress in
                    animateToMainView = animation
                    self.progress = progress
                }
        }
    }
    
    
}

#Preview {
    //    ProfileView()
    //        .environment(AppData())
    //        .preferredColorScheme(.dark)
    ContentView()
}
