//
//  oShape.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 24/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

class OShape : Shape {
    
    /*
        |0-| 1|
        |2 | 3|
     
        - marks row/colun indicator
 
    */
    
    
    // square shape does not rotate
    
    override var blockRowColumnPosition: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        
        return [
            
            Orientation.Zero:           [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.Ninety:         [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.HunderedEighty: [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.TwoSeventy:     [(0, 0), (1, 0), (0, 1), (1, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>] {
        
        return [
        
            Orientation.Zero:           [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:         [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.HunderedEighty: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy:     [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
    
}
