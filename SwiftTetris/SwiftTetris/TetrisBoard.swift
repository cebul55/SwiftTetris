//
//  TetrisBoard.swift
//  SwiftTetris
//
//  Created by Bartosz Cybulski on 16/10/2018.
//  Copyright © 2018 Bartosz Cybulski. All rights reserved.
//

class TetrisBoard<T> {
    
    let columns : Int
    let rows    : Int
    
    var array: Array<T?>
    
    init(columns: Int, rows: Int){
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(repeating: nil, count: columns * rows)
    }
    
    subscript(column: Int, row: Int) ->T? {
        get {
            return array[(row*columns)+column]
        }
        
        set (newValue) {
            array[(row*columns)+column] = newValue
        }
    }
}
