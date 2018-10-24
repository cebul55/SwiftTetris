//
//  SwiftTetris.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 25/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

let NumberColumns   = 10
let NumberRows      = 20

let StartingColumn  = 4
let StartingRow     = 0

let PreviewColumn   = 12
let PreviewRow      = 1

class SwiftTetris {
    
    var board: TetrisBoard<Block>
    var nextShape:  Shape?
    var fallingShape: Shape?
    
    init() {
   
        fallingShape = nil
        nextShape = nil
        board = TetrisBoard<Block>(columns: NumberColumns, rows: NumberRows)

    }
    
    func beginGame() {
        
        if (nextShape == nil) {
            nextShape = Shape.random(startingColumn: PreviewColumn, startingRow: PreviewRow )
        }
        
    }
    
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        
        fallingShape = nextShape
        nextShape = Shape.random(startingColumn: PreviewColumn, startingRow: PreviewRow)
        fallingShape?.moveTo(column: StartingColumn, row: StartingRow)
        
        return (fallingShape , nextShape)
    }
}
