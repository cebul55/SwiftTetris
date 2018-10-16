//
//  GameViewController.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 11/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene : GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        //create and configure the scene
        scene = GameScene(size : skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
