//
//  Extensions.swift
//  MusicStreamer
//
//  Created by Adam Chin on 5/24/23.
//


import SwiftUI

extension EnvironmentValues {
    var gridRadiusPct: CGFloat {
        get { return self[GridRadiusPctKey.self] }
        set { self[GridRadiusPctKey.self] = newValue }
    }
    var gridShadow: CGFloat {
        get { return self[GridShadowKey.self] }
        set { self[GridShadowKey.self] = newValue }
    }

    var paletteRadiusPct: CGFloat {
        get { return self[PaletteRadiusPctKey.self] }
        set { self[PaletteRadiusPctKey.self] = newValue }
    }

    var paletteShadow: CGFloat {
        get { return self[PaletteShadowKey.self] }
        set { self[PaletteShadowKey.self] = newValue }
    }
}

public struct GridRadiusPctKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0.12
}

public struct GridShadowKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 8
}

public struct PaletteRadiusPctKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 1.0
}

public struct PaletteShadowKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 3
}
