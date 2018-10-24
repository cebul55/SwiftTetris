//
//  IShape.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 24/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

class IShape : Shape {
    
    /*
        0 , 180
        |1-|
        |2 |
        |3 |
        |4 |
     
        90, 270
     
        |1 |2-|3 |4 |
     
    */
    
    override var blockRowColumnPosition: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        
        return [
        
            Orientation.Zero:           [(0, 0), (0, 1), (0, 2), (0, 3)],
            Orientation.Ninety:         [(-1,0), (0, 0), (1, 0), (2, 0)],
            Orientation.HunderedEighty: [(0, 0), (0, 1), (0, 2), (0, 3)],
            Orientation.TwoSeventy:     [(-1,0), (0, 0), (1, 0), (2, 0)]
        
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]  {
        
        return [
            
            Orientation.Zero:           [blocks[FourthBlockIdx]],
            Orientation.Ninety:         blocks,
            Orientation.HunderedEighty: [blocks[FourthBlockIdx]],
            Orientation.TwoSeventy:     blocks
            
        ]
    }
}
