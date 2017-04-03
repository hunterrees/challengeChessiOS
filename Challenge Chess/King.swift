//
//  King.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 3/3/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import Foundation

class King: ChessPiece {
    
    var moved = false
    
    override func isValidMove(_ startX: Int, startY: Int, destinationX: Int, destinationY: Int, board: [[BoardSpace]]) -> (Bool) {
        
        //call GameLogic to check
        
        return false
    
    }
    
    func validCastlingMove(_ startRookX: Int, endRookX: Int, startEmptyX: Int, endEmptyX: Int, y: Int, movementLeft: Bool, board: [[BoardSpace]]) -> Bool{
        
        //call GameLogic to check
        
        return false
        
    }
    
}
