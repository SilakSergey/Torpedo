//
//  GameViewController.swift
//  Torpedo
//
//  Created by Sergey Silak on 10.05.2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MainMenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
       //     view.showsPhysics = true
       //     view.showsFPS = true
       //     view.showsNodeCount = true
        }
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

       super.viewWillTransition(to: size, with: coordinator)

       guard
           let skView = self.view as? SKView,
           let canReceiveRotationEvents = skView.scene as? CanReceiveTransitionEvents else { return }

       canReceiveRotationEvents.viewWillTransition(to: size)
   }
}
