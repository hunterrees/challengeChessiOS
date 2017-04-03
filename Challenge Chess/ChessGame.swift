//
//  ChessGame.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 3/3/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import Foundation
import UIKit

/**
 Simple enumeration to keep track of the type of game being played
 - HumanVsHuman
 - HumanVsComputer
 - ComputerVsComputer
 */
enum GameType{
    case humanVsHuman
    case humanVsComputer
    case humanVsMachineLearning
}

/**
 The IconSet structure. Creates and holds each icon for each chess piece.
 */
struct IconSet {
    var whitePawn: UIImage!
    var whiteRook: UIImage!
    var whiteKnight: UIImage!
    var whiteBishop: UIImage!
    var whiteQueen: UIImage!
    var whiteKing: UIImage!
    
    var blackPawn: UIImage!
    var blackRook: UIImage!
    var blackKnight: UIImage!
    var blackBishop: UIImage!
    var blackQueen: UIImage!
    var blackKing: UIImage!
    
    init(iconSetName: String){
        whitePawn = UIImage(named: iconSetName + "_white_pawn")
        whiteRook = UIImage(named: iconSetName + "_white_rook")
        whiteKnight = UIImage(named: iconSetName + "_white_knight")
        whiteBishop = UIImage(named: iconSetName + "_white_bishop")
        whiteQueen = UIImage(named: iconSetName + "_white_queen")
        whiteKing = UIImage(named: iconSetName + "_white_king")
        
        blackPawn = UIImage(named: iconSetName + "_black_pawn")
        blackRook = UIImage(named: iconSetName + "_black_rook")
        blackKnight = UIImage(named: iconSetName + "_black_knight")
        blackBishop = UIImage(named: iconSetName + "_black_bishop")
        blackQueen = UIImage(named: iconSetName + "_black_queen")
        blackKing = UIImage(named: iconSetName + "_black_king")
    }
}

/**
 Holds a captured `ChessPiece` and the `NSImageView` that it's being displayed in.
 */
struct CapturedPieceImageView{
    var piece: ChessPiece!
    var imageView: UIImageView!
}

var chessBoard:Board?
var whiteCapturedPieces = [CapturedPieceImageView]()
var blackCapturedPieces = [CapturedPieceImageView]()
var iconSet:IconSet?
var iconSetName:String = ""
var whitePlayerName:String = ""
var blackPlayerName:String = ""

class ChessGame{
    
    let gameWindow : UIView! = nil
    
    var playerTurn = PieceColor.white
    
    /**
     Displays the captured piece in the game's interface.
     
     - Parameter piece: The ChessPiece to display.
     */
    func displayCapturedPiece(_ piece: ChessPiece){
        
        var pieceArray : [CapturedPieceImageView]!
        
        // We decide which array to insert the piece into, based on the piece's color.
        if(piece.pieceColor == PieceColor.black){
            pieceArray = whiteCapturedPieces
        }
        else{
            pieceArray = blackCapturedPieces
        }
        
        for i in 0...15{
            if(pieceArray[i].piece == nil){
                // Once we find the first available slot in pieceArray, we store the piece in that slot, and display the piece's icon.
                pieceArray[i].piece = piece
                pieceArray[i].imageView.image = piece.pieceImage
                return
            }
        }
        
    }

    /**
     The ChessGame class constructor.
     
     - Parameter gameType: The `GameType` of the game.
     - Parameter difficulty: The difficulty of the AI to be played against, if any. Currently has no effect.
     - Parameter whitePlayerName: The name of white side's player.
     - Parameter blackPlayerName: The name of black side's player.
     - Parameter iconSetName: The name of the `IconSet` to be used.
     */
    init(gameType: GameType, difficulty: Int!, whitePlayerNameParam: String, blackPlayerNameParam: String, iconSetNameParam: String){
        blackPlayerName = blackPlayerNameParam
        whitePlayerName = whitePlayerNameParam
        iconSetName = iconSetNameParam
        
//        // We rely on storyboard instantiation for each instance of a chess game. Here we grab the NSWindowController from the storyboard, and do a few more tweaks before the game starts.
//        let storyboard = UIStoryboard(name: "Game", bundle: nil)
//        let gameController = storyboard.instantiateViewController(withIdentifier: "Board") as UIViewController!
////        gameWindow.title = whitePlayerName + " vs " + blackPlayerName + ", ft. John Cena"
//        chessBoard = gameController as? Board
//        
//        chessBoard?.setUp()
//        
//        let gameWindow = chessBoard?.view
//        
//        // Here we programatically add the NSImageViews for the CapturedPieceImageView objects.
//        var view = gameWindow, size = CGFloat(18), x = CGFloat(44), y = CGFloat(40)
//        for i in 0...15{
//            let whiteImageView = UIImageView(frame: CGRect(origin: CGPoint(x: x, y:y), size: CGSize(width:size, height:size)))
//
//            view?.addSubview(whiteImageView)
//            whiteCapturedPieces.append(CapturedPieceImageView(piece: nil, imageView: whiteImageView))
//            
//            let blackImageView = UIImageView(frame: CGRect(origin: CGPoint(x: x + 355, y:y), size: CGSize(width: size, height: size)))
//            view?.addSubview(blackImageView)
//            blackCapturedPieces.append(CapturedPieceImageView(piece: nil, imageView: blackImageView))
//            
//            x += size
//            if(i == 7){
//                y -= 20
//                x = 44
//            }
//        }
//        
//        // Lastly, we create the IconSet, populate the chess board, and give values to a few more labels.
//        iconSet = IconSet(iconSetName: iconSetName.lowercased())
//        chessBoard?.populateBoard(iconSet!)
//        chessBoard?.currentPlayerTurnLabel.text = whitePlayerName + "'s"
//        chessBoard?.whitePlayerLabel.text = whitePlayerName + " - White"
//        chessBoard?.blackPlayerLabel.text = blackPlayerName + " - Black"
//        chessBoard?.chessGame = self
//        
        

    }
    
    
    /**
     Changes which player's turn it is.
     */
    func newPlayerMove(){
        if(playerTurn == .white){
            playerTurn = .black
            chessBoard?.currentPlayerTurnLabel.text = blackPlayerName + "'s"
        }
        else{
            playerTurn = .white
            chessBoard?.currentPlayerTurnLabel.text = whitePlayerName + "'s"
        }
    }

}

