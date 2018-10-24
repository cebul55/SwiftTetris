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
    var swiftTetris: SwiftTetris!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        //create and configure the scene
        scene = GameScene(size : skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        scene.tick = didTick
        swiftTetris = SwiftTetris()
        swiftTetris.beginGame()
        
        skView.presentScene(scene)
        
        
        scene.addPreviewShapeToScene(shape: swiftTetris.nextShape! ){
            self.swiftTetris.nextShape?.moveTo(column: StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(shape: self.swiftTetris.nextShape! ) {
                let nextShapes = self.swiftTetris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(shape: nextShapes.nextShape!) {}
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didTick() {
        swiftTetris.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(shape: swiftTetris.fallingShape! , completion:  {} )
    }
}
