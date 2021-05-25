//
//  PreloadSea.swift
//  Torpedo
//
//  Created by Sergey Silak on 18.05.2021.
//

import Foundation
import SpriteKit

class Assets {
    static let sharedInstance = Assets()
    let sprites = SKTextureAtlas(named: "Background.atlas")

    func preloadAssets() {
        sprites.preload {
            print("Sprites preloaded")
        }
    }
}
