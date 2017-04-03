//
//  Pawn.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 3/3/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import Foundation
import UIKit

class Pawn: ChessPiece {
    
    var firstMove = true
    var justMadeDoubleStep = false
    
    var enPassantCallback: ((_ enemyX: Int, _ enemyY: Int)->())
    
    init(image: UIImage, color: PieceColor, enPassantEventHandler: @escaping ((_ enemyX: Int, _ enemyY: Int)->())){
        enPassantCallback = enPassantEventHandler
        super.init(image: image, color: color)
    }
    
    func canApplyEnPassant(_ targetX: Int, targetY: Int, board: [[BoardSpace]]) -> Bool{
        if let targetPawn = board[targetX][targetY].occupyingPiece{
            if(targetPawn.isKind(of: Pawn.self) && (targetPawn as! Pawn).justMadeDoubleStep && targetPawn.pieceColor != pieceColor){
                enPassantCallback(targetX, targetY)
                return true
            }
        }
        return false
    }
    
    override func isValidMove(_ startX: Int, startY: Int, destinationX: Int, destinationY: Int, board: [[BoardSpace]]) -> (Bool) {
        
        //call GameLogic to check
        
        return false
    
    }
    
}
