//
//  BoardSpace.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 3/3/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class BoardSpace: UIView {
    
    var occupyingPiece: ChessPiece!
    var occupyingPieceImageView: UIImageView!
    var x: Int!
    var y: Int!
    var fillColor: UIColor
    var clickEventBlock: ((BoardSpace)->())?
    let columnSize = 344/8

    init(xPixels: Int, yPixels: Int, fillWhite: Bool, clickEventHandler: ((BoardSpace)->())?){
                x = (xPixels-2)/columnSize
        y = (yPixels-2)/columnSize
        self.fillColor = UIColor.white
        super.init(frame: CGRect(origin: CGPoint(x: xPixels, y: yPixels), size: CGSize(width: columnSize+1, height:columnSize+1)))//        var titlePosition = TitlePosition.noTitle
//        var boxType = .custom
//        var borderType = .noBorder
        
        if(fillWhite){
            fillColor = UIColor.yellow
        }
        else{
            fillColor = UIColor.green
        }
        
//        self.backgroundColor = fillColor
        
        clickEventBlock = clickEventHandler
    }
    
    func setPiece(_ chessPiece: ChessPiece){
        occupyingPiece = chessPiece
        if(occupyingPieceImageView == nil){
            occupyingPieceImageView = UIImageView(frame: CGRect(x: -1, y: 0, width: columnSize-5, height: columnSize-5))
            self.addSubview(occupyingPieceImageView)
        }
        occupyingPieceImageView.image = chessPiece.pieceImage
    }
    
    func clearPiece(){
        occupyingPieceImageView.removeFromSuperview()
        occupyingPiece = nil
        occupyingPieceImageView = nil
    }
    
    func someAction(_ sender:UITapGestureRecognizer){
        clickEventBlock!(self)
        print("tapped")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
