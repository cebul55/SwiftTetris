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

let PointPerLine    = 10
let LevelThreshold  = 500

protocol SwiftTetrisDelegate {
    
    func gameDidEnd(swiftTetris: SwiftTetris)
    
    func gameDidBegin(swiftTetris: SwiftTetris)
    
    func gameShapeDidLand(swiftTetris: SwiftTetris)
    
    func gameShapeDidMove(swiftTetris: SwiftTetris)
    
    func gameShapeDidDrop(swiftTetris: SwiftTetris)
    
    func gameDidLevelUp(swiftTetris: SwiftTetris)
    
}

class SwiftTetris {
    
    var board: TetrisBoard<Block>
    var nextShape:  Shape?
    var fallingShape: Shape?
    var delegate: SwiftTetrisDelegate?
    
    var score = 0
    var level = 1
    
    init() {
   
        fallingShape = nil
        nextShape = nil
        board = TetrisBoard<Block>(columns: NumberColumns, rows: NumberRows)

    }
    
    func beginGame() {
        
        if (nextShape == nil) {
            nextShape = Shape.random(startingColumn: PreviewColumn, startingRow: PreviewRow )
        }
        
        delegate?.gameDidBegin(swiftTetris: self)
    }
    
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        
        fallingShape = nextShape
        nextShape = Shape.random(startingColumn: PreviewColumn, startingRow: PreviewRow)
        fallingShape?.moveTo(column: StartingColumn, row: StartingRow)
        
        guard detectIllegalPlacement() == false else {
            nextShape = fallingShape
            nextShape!.moveTo(column : PreviewColumn, row: PreviewRow)
            endGame()
            return (nil, nil)
        }
        
        return (fallingShape , nextShape)
    }
    
    func detectIllegalPlacement() -> Bool {
        
        guard let shape = fallingShape else {
            return false
        }
        for block in shape.blocks {
            
            if block.column < 0 || block.column >= NumberColumns || block.row < 0 || block.row >= NumberRows {
                return true
            }
            else if board[block.column, block.row] != nil {
                return true
            }
        }
        return false
    }
    
    func settleShape () {
        
        guard let shape = fallingShape else {
            return
        }
        for block in shape.blocks {
            board[block.column, block.row] = block
        }
        fallingShape = nil
        delegate?.gameShapeDidLand(swiftTetris: self)
    }
    
    func detectTouch() -> Bool {
        
        guard let shape = fallingShape else {
            return false
        }
        for bottomBlock in shape.bottomBlocks {
            if ( bottomBlock.row == NumberRows - 1 || board[bottomBlock.column, bottomBlock.row + 1 ] != nil ) {
                return true
            }
        }
        return false
    }
    
    func endGame() {
        
        score = 0
        level = 1
        delegate?.gameDidEnd(swiftTetris: self)
        
    }
    
    func removeCompletedLines() -> (linesRemoved: Array<Array<Block>>, fallenBlocks: Array<Array<Block>> ) {
        
        print("remove")
        var removedLines = Array<Array<Block>>()
        
        for row in (1..<NumberRows).reversed() {
            
            var rowOfBlocks = Array<Block>()
            
            for column in 0..<NumberColumns {
                guard let block = board[column, row] else {
                    continue
                }
                rowOfBlocks.append(block)
            }
            
            if rowOfBlocks.count == NumberColumns {
                
                removedLines.append(rowOfBlocks)
                for block in rowOfBlocks {
                    board[block.column, block.row] = nil
                }
            }
        }
        
        if removedLines.count == 0 {
            return ([], [])
        }
        
        let pointsEarned = removedLines.count * PointPerLine * level
        score += pointsEarned
        
        if score >= level * LevelThreshold {
            level += 1
            delegate?.gameDidLevelUp(swiftTetris: self)
        }
        
        var fallenBlocks = Array<Array<Block>>()
        for column in 0..<NumberColumns {
            
            var fallenBlocksArray = Array<Block>()
            
            for row in (1..<removedLines[0][0].row).reversed() {
                guard let block = board[column, row] else {
                    continue
                }
                var newRow = row
                while ( newRow < NumberRows - 1 && board[column, newRow + 1] == nil) {
                    newRow += 1
                }
                
                block.row = newRow
                board[column, row] = nil
                board[column, newRow] = block
                fallenBlocksArray.append(block)
                
            }
            
            if fallenBlocksArray.count > 0 {
                
                fallenBlocks.append(fallenBlocksArray)
            }
        }
        
        return (removedLines, fallenBlocks)
    }
    
    func removeAllBlocks() -> Array<Array<Block>> {
        
        var allBlocks = Array<Array<Block>>()
        
        for row in 0..<NumberRows {
            var rowOfblocks = Array<Block>()
            for column in 0..<NumberColumns {
                guard let block = board[column, row] else {
                    continue
                }
                rowOfblocks.append(block)
                board[column, row] = nil
            }
            allBlocks.append(rowOfblocks)
        }
        return allBlocks
    }
    
    func dropShape() {
        guard let shape = fallingShape else {
            return
        }
        
        while detectIllegalPlacement() == false {
            shape.lowerShapeByOneRow()
        }
        shape.raiseShapeByOneRow()
        delegate?.gameShapeDidDrop(swiftTetris: self)
    }
    
    func letShapeFall() {
        
        guard let shape = fallingShape else {
            return
        }
        shape.lowerShapeByOneRow()
        if detectIllegalPlacement() {
            shape.raiseShapeByOneRow()
            
            if detectIllegalPlacement() {
                endGame()
            }
            else {
                settleShape()
            }
        }
        else {
            delegate?.gameShapeDidMove(swiftTetris: self)
            if detectTouch() {
                settleShape()
            }
        }
    }
    
    func rotateShape() {
        
        guard let shape = fallingShape else {
            return
        }
        shape.rotateClockwise()
    
        guard detectIllegalPlacement() == false else {
            shape.rotateCounterClockwise()
            return
        }
        delegate?.gameShapeDidMove(swiftTetris: self)
        
    }
    
    func moveShapeLeft() {
        
        guard let shape = fallingShape else {
            return
        }
        shape.shiftLeftByOneColumn()
        guard detectIllegalPlacement() == false else {
            shape.shiftRightByOneColumn()
            return
        }
        delegate?.gameShapeDidMove(swiftTetris: self)
    }
    
    func moveShapeRight() {
        
        guard let shape = fallingShape else {
            return
        }
        shape.shiftRightByOneColumn()
        guard detectIllegalPlacement() == false else {
            shape.shiftLeftByOneColumn()
            return
        }
        delegate?.gameShapeDidMove(swiftTetris: self)
    }
    
}
