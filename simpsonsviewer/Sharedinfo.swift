//
//  Sharedinfo.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/17/21.
//

import Foundation

enum AppType: String {
    case wire = "com.vineelgolla.simpsonsviewer.pro"
    case simpsonsviewer = "com.vineelgolla.simpsonsviewer"
}

class SharedInfo {
    
    static let shared = SharedInfo()
    
    var title = ""
    var url = ""
    
    var app: AppType? {
        didSet {
            switch app {
            case .wire:
                title = "The Wire"
                url = "http://api.duckduckgo.com/?q=the+wire+characters&format=json"
            case .simpsonsviewer:
                title = "Simpsons"
                url = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
            case .none:
                title = "Simpsons"
                url = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
            }
        }
    }

}
