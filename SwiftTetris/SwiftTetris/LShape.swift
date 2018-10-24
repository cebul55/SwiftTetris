//
//  LShape.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 24/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

class LShape : Shape {
    
    /*
     0
        |1-|
        |2 |
        |3 |4 |
     90
            -
        |3 |2 |1 |
        |4 |
     180
        |4  |3-|
            |2 |
            |1 |
     270
              - |4 |
          |1 |2 |3 |
    */
    
    override var blockRowColumnPosition: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        
        return [
            
            Orientation.Zero:           [(0, 0), (0, 1), (0, 2), (1, 2)],
            Orientation.Ninety:         [(1, 1), (0, 1), (-1,1), (-1,2)],
            Orientation.HunderedEighty: [(0, 2), (0, 1), (0, 0), (-1,0)],
            Orientation.TwoSeventy:     [(-1,1), (0, 1), (1, 1), (1, 0)]
            
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]  {
        
        return [
            
            Orientation.Zero:           [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:         [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.HunderedEighty: [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]]
            
        ]
    }
}
