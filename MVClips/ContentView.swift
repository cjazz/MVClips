//
//  ContentView.swift
//  MVClips
//
//  Created by Adam Chin on 5/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            MainView(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)

        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
