//
//  SShape.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 25/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

class SShape : Shape {
   /*
     0 , 180
        |1-|
        |2 |3 |
            |4|
     90 . 270
        |- |2 |1 |
        |4 |3 |
    */
    
    override var blockRowColumnPosition: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        
        return [
            
            Orientation.Zero:           [(0, 0), (0, 1), (1, 1), (1, 2)],
            Orientation.Ninety:         [(2, 0), (1, 0), (1, 1), (0, 1)],
            Orientation.HunderedEighty: [(0, 0), (0, 1), (1, 1), (1, 2)],
            Orientation.TwoSeventy:     [(2, 0), (1, 0), (1, 1), (0, 1)]
            
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]  {
        
        return [
            
            Orientation.Zero:           [blocks[FirstBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.Ninety:         [blocks[FirstBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.HunderedEighty: [blocks[FirstBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.TwoSeventy:     [blocks[FirstBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
            
        ]
    }
}
