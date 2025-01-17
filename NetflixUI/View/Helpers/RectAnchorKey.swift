//
//  RectAnchorKey.swift
//  NetflixUI
//
//  Created by Miguel Angel Gutierrez Maya on 23/06/24.
//

import SwiftUI

struct RectAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(
        value: inout [String: Anchor<CGRect>],
        nextValue: () -> [String: Anchor<CGRect>]
    ) {
        value.merge(nextValue()) { $1 }
    }
}

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
