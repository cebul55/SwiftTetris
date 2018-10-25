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

class GameViewController: UIViewController, SwiftTetrisDelegate, UIGestureRecognizerDelegate {
    
    var scene : GameScene!
    var swiftTetris: SwiftTetris!
    
    var panPointReference:CGPoint?

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    
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
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
    
        swiftTetris.rotateShape()
    
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        
        let currentPoint = sender.translation(in: self.view)
        if let originalPosition = panPointReference {
            
            if abs(currentPoint.x - originalPosition.x) > (BlockSize * 0.9) {
                
                if sender.velocity(in: self.view).x > CGFloat(0) {
                    swiftTetris.moveShapeRight()
                    panPointReference = currentPoint
                }
                else {
                    swiftTetris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        }
        else if sender.state == .began {
            panPointReference = currentPoint
        }
        
    }
    
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        swiftTetris.dropShape()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer is UISwipeGestureRecognizer {
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
        }
        else if gestureRecognizer is UIPanGestureRecognizer {
            if otherGestureRecognizer is UITapGestureRecognizer {
                return true
            }
        }
        return false
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
        
        scene.stopTicking()
        
        scene.redrawShape(shape: swiftTetris.fallingShape!) {
            swiftTetris.letShapeFall()
        }
    }
    
    func gameShapeDidLand(swiftTetris: SwiftTetris) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(swiftTetris: SwiftTetris) {
        scene.redrawShape(shape: swiftTetris.fallingShape! ) {}
    }
    
}
