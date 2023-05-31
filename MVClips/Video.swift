//
//  Album.swift
//  MVClips
//
//  Created by Adam Chin on 5/29/23.
//

import SwiftUI

struct Video: Identifiable{
    var id = UUID().uuidString
    var name: String

}


var videos: [Video] = [

    Video(name: "Jeff Beck - Emotion & Commotion"),
    Video(name: "Jeff Beck - There And Back"),
    Video(name: "Jeff Beck - Blow By Blow"),
    Video(name: "Jeff Beck - Truth"),
    Video(name: "Jeff Beck - Beck-Ola"),
    Video(name: "Jeff Beck Group"),
    Video(name: "Jeff Beck's Guitar Shop"),
    Video(name: "You Had it Coming"),
    Video(name: "Jeff Beck with The Jan Hammer Group Live"),
    Video(name: "Loud Hailer")


]
