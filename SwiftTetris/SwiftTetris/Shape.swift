//
//  Shape.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 16/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

import SpriteKit

let NumberOrientations: UInt32 = 4

enum Orientation: Int, CustomStringConvertible {
    
    case Zero = 0 , Ninety , HunderedEighty , TwoSeventy
    
    var description: String {
        
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .HunderedEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    
    static func random() -> Orientation {
        return Orientation(rawValue: Int (arc4random_uniform(NumberOrientations)))!
    }
    
    static func rotate(orientation : Orientation, clockwise : Bool) -> Orientation {
        
        var rotated = orientation.rawValue + ( clockwise ? 1 : -1 )
        if rotated > Orientation.TwoSeventy.rawValue {
            rotated = Orientation.Zero.rawValue
        }
        else if (rotated < 0){
            rotated = Orientation.TwoSeventy.rawValue
        }
        
        return Orientation(rawValue: rotated)!
    }
}

//beginning of Shape class

let NumberOfShapeTypes  :   UInt32  = 7
let FirstBlockIdx       :   Int     = 0
let SecondBlockIdx      :   Int     = 1
let ThirdBlockIdx       :   Int     = 2
let FourthBlockIdx      :   Int     = 3

class Shape : Hashable , CustomStringConvertible {
    
    let color       : BlockColor
    var blocks      = Array<Block>()
    var orientation : Orientation
    var column      : Int
    var row         : Int
    
    // Subclasses must override this property
    var blockRowColumnPosition : [Orientation : Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
    // Subclasses must override this property
    var bottomBlocksForOrientations : [Orientation: Array<Block>] {
        return [:]
    }
    
    var BottomBlocks : Array<Block> {
        
        guard let bottomBlocks = bottomBlocksForOrientations[orientation] else {
            return []
        }
        
        return bottomBlocks
    }
    
    //hashable
    var hashValue : Int {
        return blocks.reduce(0) {$0.hashValue ^ $1.hashValue }
    }
    
    //customStrinConvertibe
    
    var description: String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
    }
    
    init ( column: Int, row: Int,color : BlockColor, orientation: Orientation){
        
        self.column         = column
        self.row            = row
        self.color          = color
        self.orientation    = orientation
        
        initializeBlocks()
    }
    
    convenience init(column : Int, row : Int) {
        self.init(column: column , row : row, color : BlockColor.random(), orientation : Orientation.random())
    }
    
    final func initializeBlocks() {
        
        guard let blockRowColumnTranslations = blockRowColumnPosition[orientation] else {
            return
        }
        
        blocks = blockRowColumnTranslations.map { (diff) -> Block in
            return Block (column : column + diff.columnDiff, row : row + diff.rowDiff, color : color)
        }
    }
    
    static func ==(lhs : Shape, rhs : Shape ) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
    
}

//TODO add shapes subclasses
