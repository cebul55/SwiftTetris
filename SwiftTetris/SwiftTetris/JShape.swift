//
//  JShape.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 24/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

class JShape : Shape {
    
    /*
     0
            -  |1 |
               |2 |
            |4 |3 |
     90
            |4-|
            |3 |2 |1 |
     180
            |3-|4 |
            |2 |
            |1 |
     270
            |1-|2 |3 |
                  |4 |
    */

    override var blockRowColumnPosition: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        
        return [
            
            Orientation.Zero:           [(1, 0), (1, 1), (1, 2), (0, 2)],
            Orientation.Ninety:         [(2, 1), (1, 1), (0, 1), (0, 0)],
            Orientation.HunderedEighty: [(0, 2), (0, 1), (0, 0), (1, 0)],
            Orientation.TwoSeventy:     [(0, 0), (1, 0), (2, 0), (2, 1)]
            
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]  {
        
        return [
            
            Orientation.Zero:           [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:         [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.HunderedEighty: [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]]
            
        ]
    }
}
