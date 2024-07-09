//
//  Profile.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 23/06/24.
//

import Foundation

struct Profile: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    
    var sourceAnchorID: String {
        return id.uuidString + "SOURCE"
    }
    
    var destinationAnchorID: String {
        return id.uuidString + "DESTINATION"
    }
}

var mockProfiles: [Profile] = [
    .init(name: "Ijustine", icon: "iJustine"),
    .init(name: "Jenaa", icon: "Jenna")
]
