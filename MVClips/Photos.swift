//
//  Photos.swift
//  MVClips
//
//  Created by Adam Chin on 5/24/23.
//

import Foundation

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
