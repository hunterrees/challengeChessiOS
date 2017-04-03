//
//  Queen.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 3/3/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import Foundation
import UIKit

class Queen: ChessPiece {
    
    var takenOverPawnImage: UIImage!
    
    init(image: UIImage, pawnImage: UIImage!, color: PieceColor){
        super.init(image: image, color: color)
        takenOverPawnImage = pawnImage
    }
    
    override func isValidMove(_ startX: Int, startY: Int, destinationX: Int, destinationY: Int, board: [[BoardSpace]]) -> (Bool) {
        
        //call GameLogic to check
        
        return false
        
    }
    
}
