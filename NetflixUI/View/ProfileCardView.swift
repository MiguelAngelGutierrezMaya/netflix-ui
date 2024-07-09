//
//  ProfileCardView.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 23/06/24.
//

import SwiftUI

struct ProfileCardView: View {
    @Environment(AppData.self) private var appData
    
    /// Attributes
    var profile: Profile
    var animateToCenter: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            
            let status = profile.id == appData.watchingProfile?.id
            
            GeometryReader { _ in
                Image(profile.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                    .opacity(animateToCenter ? 0 : 1)
                
            }
            .animation(
                status ? .none : .bouncy(duration: 0.35), value: animateToCenter
            )
            .frame(width: 100, height: 100)
            .anchorPreference(key: RectAnchorKey.self, value: .bounds, transform: { anchor in
                return [profile.sourceAnchorID: anchor]
            })
            .onTapGesture {
                appData.watchingProfile = profile
                appData.animateProfile = true
            }
            
            Text(profile.name)
                .fontWeight(.semibold)
                .lineLimit(1)
        }
    }
}

#Preview {
    ProfileView()
        .environment(AppData())
        .preferredColorScheme(.dark)
}
