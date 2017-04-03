//
//  ChessPiece.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 3/3/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import Foundation
import UIKit

enum PieceColor{
    case black
    case white
}

class ChessPiece: NSObject{
    
    var pieceImage: UIImage!
    var pieceColor: PieceColor!
    
    init(image: UIImage, color: PieceColor){
        super.init()
        pieceColor = color
        pieceImage = image
    }
    
    func isValidMove(_ startX: Int, startY: Int, destinationX: Int, destinationY: Int, board: [[BoardSpace]]) -> (Bool){
        return false
    }
    
    func spaceIsEmpty(_ x: Int, y: Int, board: [[BoardSpace]]) -> Bool{
        return board[x][y].occupyingPiece == nil
    }

    
    //func getPossibleMoves(location)
    //highlight the result spaces

}
