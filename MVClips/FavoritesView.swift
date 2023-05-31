//
//  FavoritesView.swift
//  MVClips
//
//  Created by Adam Chin on 5/24/23.
//

import SwiftUI

struct FavoritesView: View {
    var pct: CGFloat
    let color: Color
    var body: some View {
        EmptyView()
            .modifier(FavoritesModifier(pct: pct, color: color))
    }
}

struct FavoritesModifier: AnimatableModifier {

    @State private var scale: Double = 1

    @Environment(\.paletteRadiusPct) var paletteRadiusPct: CGFloat
    @Environment(\.paletteShadow) var paletteShadow: CGFloat

    @Environment(\.gridRadiusPct) var gridRadiusPct: CGFloat
    @Environment(\.gridShadow) var gridShadow: CGFloat

    var pct: CGFloat
    let color: Color

    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }

    func body(content: Content) -> some View {

        let shadow = (paletteShadow - gridShadow) * pct + gridShadow

        return Rectangle()
            .fill(color)
            .opacity(0.4)
            .aspectRatio(1.0, contentMode: .fit)
            .animation(Animation.easeInOut(duration: 0.5).repeatCount(1, autoreverses: true), value: scale*5)
            .aspectRatio(contentMode: .fit)
            .padding(2 * pct)
            .shadow(radius: shadow)
            .padding(4 * pct)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(pct: 0.3, color: .blue)
    }
}
