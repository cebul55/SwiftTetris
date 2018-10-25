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

class GameViewController: UIViewController, SwiftTetrisDelegate {
    
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
        swiftTetris.delegate = self
        swiftTetris.beginGame()
        
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didTick() {
        swiftTetris.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = swiftTetris.newShape()
        
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        
        self.scene.addPreviewShapeToScene(shape: newShapes.nextShape!) {}
        self.scene.movePreviewShape(shape: fallingShape ) {
            self.view.isUserInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(swiftTetris: SwiftTetris) {
        
        if swiftTetris.nextShape != nil && swiftTetris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(shape: swiftTetris.nextShape! ) {
                self.nextShape()
            }
        }
        else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftTetris: SwiftTetris) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftTetris: SwiftTetris) {
        
    }
    
    func gameShapeDidDrop(swiftTetris: SwiftTetris) {
        
    }
    
    func gameShapeDidLand(swiftTetris: SwiftTetris) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(swiftTetris: SwiftTetris) {
        scene.redrawShape(shape: swiftTetris.fallingShape! ) {}
    }
    
}
