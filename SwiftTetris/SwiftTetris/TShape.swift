//
//  tShape.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 24/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

class TShape : Shape {
    
    /*
        0
             - |1 |
            |2 |3 | 4|
        90
            -
            |2 |
            |3 |1 |
            |4 |
        180
            -
            |2 |3 |4 |
               |1 |
        270
     
             -  |2 |
            |1  |3 |
                |4 |
     
    */
    
    override var blockRowColumnPosition: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        
        return [
        
            Orientation.Zero:           [(1, 0), (0, 1), (1, 1), (2, 1)],
            Orientation.Ninety:         [(2, 1), (1, 0), (1, 1), (1, 2)],
            Orientation.HunderedEighty: [(1, 2), (0, 1), (1, 1), (2, 1)],
            Orientation.TwoSeventy:     [(0, 1), (1, 0), (1, 1), (1, 2)]
        
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]  {
        return [
        
            Orientation.Zero:           [blocks[SecondBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:         [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.HunderedEighty: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy:     [blocks[FirstBlockIdx], blocks[FourthBlockIdx]]
        
        ]
    }
}
