//
//  AnimationLayerView.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 23/06/24.
//

import SwiftUI

struct AnimationLayerView: View {
    @Environment(AppData.self) private var appData
    
    /// Attributes
    var value: [String: Anchor<CGRect>]
    var progress: CGFloat
    var animateToCenter: Bool
    var animateToMainView: Bool
    var setAnimation: (Bool) -> Void
    var setAnimationView: (Bool, CGFloat) -> Void
    
    var body: some View {
        GeometryReader { proxy in
            if let profile = appData.watchingProfile,
               let sourceAnchor = value[profile.sourceAnchorID], appData.animateProfile {
                let sRect = proxy[sourceAnchor]
                let screenRect = proxy.frame(in: .global)
                /// Positions
                let sourcePosition = CGPoint(
                    x: sRect.midX,
                    y: sRect.midY
                )
                let centerPosition = CGPoint(
                    x: screenRect.width / 2,
                    y: (screenRect.height / 2) - 40
                )
                let destinationPosition = CGPoint(
                    x: appData.tabProfileRect.midX,
                    y: appData.tabProfileRect.midY
                )
                let animationPath = Path { path in
                    path.move(to: centerPosition)
                    path.addQuadCurve(to: destinationPosition, control: CGPoint(
                        x: centerPosition.x * 2,
                        y: centerPosition.y - (centerPosition.y / 0.8)
                    ))
                }
                // animationPath.stroke(lineWidth: 2)
                
                let endPosition = animationPath.trimmedPath(from: 0, to: 1).currentPoint ?? destinationPosition
                let currentPosition = animationPath.trimmedPath(from: 0, to: 0.97).currentPoint ?? destinationPosition
                
                let diff = CGSize(
                    width: endPosition.x - currentPosition.x,
                    height: endPosition.y - currentPosition.y
                )
                
                /// Selected profile Image View With Loading Indicator
                ZStack {
                    Image(profile.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: animateToMainView ? 25 : sRect.width,
                            height: animateToMainView ? 25 : sRect.height
                        )
                        .clipShape(.rect(cornerRadius: animateToMainView ? 4 : 10))
                        .animation(
                            .snappy(
                                duration: 0.3,
                                extraBounce: 0
                            ),
                            value: animateToMainView
                        )
                        .opacity(animateToMainView && appData.activeTab != .account ? 0.6 : 1)
                        .modifier(
                            AnimatedPositionModifier(
                                source: sourcePosition,
                                center: centerPosition,
                                destination: destinationPosition,
                                animateToCenter: animateToCenter,
                                animateToMainView: animateToMainView,
                                path: animationPath,
                                progress: progress
                            )
                        )
                        .offset(animateToMainView ? diff : .zero)
                    //                        .position(
                    //                            animateToCenter ? (
                    //                                animateToMainView ? destinationPosition : centerPosition
                    //                            ) : sourcePosition
                    //                        )
                    
                    /// Custom Netflix Style Indicator
                    NetflixLoader()
                        .frame(
                            width: 60,
                            height: 60
                        )
                        .offset(y: 80)
                        .opacity(animateToCenter ? 1 : 0)
                        .opacity(animateToMainView ? 0 : 1)
                }
                .transition(.identity)
                .task {
                    guard !animateToCenter else { return }
                    await animateUser()
                }
            }
        }
    }
    
    func animateUser() async {
        withAnimation(
            .bouncy(
                duration: 0.35
            )
        ) {
            // animateToCenter = true
            setAnimation(true)
        }
        
        await loadContents()
        
        withAnimation(
            .snappy(
                duration: 0.6,
                extraBounce: 0.1
            ),
            completionCriteria: .removed
        ) {
            setAnimationView(true, 0.97)
            appData.hideMainView = false
        } completion: {
            appData.showProfileView = false
            appData.animateProfile = false
        }
    }
    
    /// Load Contents
    func loadContents() async {
        /// Load Any network content here
        try? await Task.sleep(for: .seconds(1))
    }
}

struct AnimatedPositionModifier: ViewModifier, Animatable {
    var source: CGPoint
    var center: CGPoint
    var destination: CGPoint
    var animateToCenter: Bool
    var animateToMainView: Bool
    var path: Path
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .position(
                animateToCenter ? (
                    animateToMainView ? (path.trimmedPath(from: 0, to: progress).currentPoint ?? center) : center
                ) : source
            )
    }
}

#Preview {
    //    ProfileView()
    //        .environment(AppData())
    //        .preferredColorScheme(.dark)
    ContentView()
}
