//
//  Board.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 3/3/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import Foundation
import UIKit

var globalChessGame:ChessGame?

/**
 The `Board` class encapsulates the actual "visual" portion of a ChessGame instance.
 It can be thought of as the physical playing board in a real-life game of chess.
 */
class Board:UIViewController{
    
    /**
     The `NSTextField` that displays the name of whomever's turn it is.
     */
    @IBOutlet weak var currentPlayerTurnLabel: UILabel!
    /**
     The `NSTextField` that says "turn".
     */
    @IBOutlet weak var turnLabel: UILabel!
    
    /**
     The `NSTextField` that displays the white player's name.
     */
    @IBOutlet weak var whitePlayerLabel: UILabel!
    
    /**
     The `NSTextField` that displays the white player's name.
     */
    @IBOutlet weak var blackPlayerLabel: UILabel!
    
    @IBOutlet weak var boardImage: UIImageView!
    /**
     The game's corresponding `ChessGame` instance
     */
    var chessGame: ChessGame!
    
    /**
     2D array to hold the game's `BoardSpace`s in a grid pattern.
     Note that the coordinates start from the bottom-left, at 0,0.
     */
    var boardSpaces = [[BoardSpace]]()
    
    /**
     The `BoardSpace` currently highlighted.
     */
    var highlightedSpace: BoardSpace!
    
    /**
     The normal background `NSColor` of the `BoardSpace` that is currently highlighted.
     Needed to restore the `BoardSpace`'s color back to normal after its highlight is removed.
     */
    var highlightedSpaceColor: UIColor!
    
    
    /**
     The `ChessPiece` that moved during the last turn. Used to detect the conditions for an en passant move.
     */
    var lastPieceMoved: ChessPiece!
    
    /**
     Indicates whether the game has finished.
     */
    var gameOver = false
    
    /**
     Our En passant callback code block. Also known as a "callback function", and functionally equivalent
     to function pointers, these are basically blocks of code wrapped up to act like a normal variable. They provide an easy
     way to interact between classes, and are much more flexible than other methods, such as delegation or notification usage.
     In this case, it's being used to handle the extra board management required when a pawn destroys another pawn using en passant.
     
     - Parameter enemyX: The x-coordinate of the enemy pawn
     - Parameter enemyY: The y-coordinate of the enemy pawn
     */
    var enPassantBlock: ((_ enemyX: Int, _ enemyY: Int)->())!
    
    /**
     Highlights a `BoardSpace`.
     
     - Parameter space: The `BoardSpace` to highlight.
     */
    func highlightPiece(_ space: BoardSpace){
        if let piece = highlightedSpace{
            piece.fillColor = highlightedSpaceColor
        }
        highlightedSpace = space
        highlightedSpaceColor = space.fillColor
        space.fillColor = UIColor.yellow
    }
    
    /**
     Removes highlighting from the currently-highlighted `BoardSpace`.
     */
    func clearHighlight(){
        if highlightedSpace != nil{
            highlightedSpace.fillColor = highlightedSpaceColor
        }
        highlightedSpace = nil
    }
    
    /**
     The constructor for the `Board` class. Called automatically when instantiated from the storyboard.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let whiteName = "whiteName", blackName = "blackName"
        // If the sides have been switched, then we invert the white and black player name assignments
    
        
        // We create the new ChessGame object with the given parameters, and add it to the ChessGame array.
        globalChessGame = ChessGame(gameType: .humanVsHuman, difficulty: nil, whitePlayerNameParam: whiteName, blackPlayerNameParam: blackName, iconSetNameParam: ("maya"))
        // Here we define the callback block for En passant moves.
        enPassantBlock = {
            (x: Int, y: Int) in
            let capturedPiece = self.boardSpaces[x][y].occupyingPiece
            self.boardSpaces[x][y].clearPiece()
            self.chessGame.displayCapturedPiece(capturedPiece!)
        }
        
        var whiteSpace = false
        
        // The sole purpose of this column loop, and the row loop two lines later, is to populate the empty board with BoardSpaces. However, a
        // clickEventHandler block must be passed to the BoardSpace constructor; declaring the block here negates the need to hold a reference
        // to it, but has the unfortunate side effect of greatly ballooning the size of this section of otherwise-unrelated code.
        let columnSize = 344/8
        for column in 0 ..< 8 {
            var columnSection = [BoardSpace]()
            for row in 0 ..< 8 {
                let boardSpace = BoardSpace(xPixels: column*columnSize+20, yPixels: row*columnSize+134, fillWhite: whiteSpace){
                    
                    // Everything between this line and line 202 is the definition of the clickEventHandler callback.
                    space in
                    
                    print("space clicked!!!")
                    
                    // We immediately end the function if the game is over, as we want to ignore all clicks on any BoardSpace.
                    if(self.gameOver){
                        return
                    }
                    
                    let occupant = space.occupyingPiece
                    var occupantIsAlly = false
                    if occupant != nil && occupant?.pieceColor == self.chessGame.playerTurn{
                        occupantIsAlly = true
                    }
                    
                    if let highlightedSpace = self.highlightedSpace, let highlightedPiece = self.highlightedSpace!.occupyingPiece{ // A piece is already highlighted
                        if highlightedSpace.x == space.x && highlightedSpace.y == space.y { // The highlighted piece is clicked
                            self.clearHighlight()
                            return
                        }
                        if !occupantIsAlly && highlightedPiece.isValidMove(highlightedSpace.x, startY: highlightedSpace.y, destinationX: space.x, destinationY: space.y, board: self.boardSpaces){
                            space.setPiece(highlightedPiece)
                            highlightedSpace.clearPiece()
                            
                            let isWhite = highlightedPiece.pieceColor == PieceColor.white
                            
                            if highlightedPiece.isKind(of: Pawn.self) && (isWhite && space.y == 7 || !isWhite && space.y == 0) {
                                var queenImage = iconSet?.whiteQueen
                                if !isWhite {
                                    queenImage = iconSet?.blackQueen
                                }
                                space.setPiece(Queen(image: queenImage!, pawnImage: highlightedPiece.pieceImage, color: .white))
                            }
                            
                            if occupant != nil{ // An enemy has been destroyed
                                if (occupant?.isKind(of: Queen.self))! && (occupant as! Queen).takenOverPawnImage != nil{
                                    self.chessGame.displayCapturedPiece(Pawn(image: (occupant as! Queen).takenOverPawnImage, color: .white, enPassantEventHandler: self.enPassantBlock))
                                }
                                else{
                                    self.chessGame.displayCapturedPiece(occupant!)
                                    if (occupant?.isKind(of: King.self))!{
                                        if self.chessGame.playerTurn == PieceColor.white{
                                            self.currentPlayerTurnLabel.text = whitePlayerName
                                        }
                                        else{
                                            self.currentPlayerTurnLabel.text = blackPlayerName
                                        }
                                        self.turnLabel.text = "wins!"
//                                        self.chessGame.gameWindow.title = self.chessGame.gameWindow.title +  " - (\(self.currentPlayerTurnLabel.text) wins!)"
                                        self.gameOver = true
                                        self.clearHighlight()
                                        return
                                    }
                                }
                            }
                            if self.lastPieceMoved != nil && self.lastPieceMoved.isKind(of: Pawn.self){
                                (self.lastPieceMoved as! Pawn).justMadeDoubleStep = false
                            }
                            self.lastPieceMoved = space.occupyingPiece
                            self.chessGame.newPlayerMove()
                        }
                        else{
                            if occupantIsAlly{
                                self.clearHighlight()
                                self.highlightPiece(space)
                                return
                            }
                        }
                    }
                        
                    else if occupantIsAlly{
                        self.highlightPiece(space)
                        return
                    }
                    self.clearHighlight()
                } // End of clickEventHandler.
                self.view.addSubview(boardSpace)
                columnSection.append(boardSpace)
                whiteSpace = !whiteSpace
            }
            boardSpaces.append(columnSection)
            whiteSpace = !whiteSpace
        }
        
        chessBoard = self
        
        // Here we programatically add the NSImageViews for the CapturedPieceImageView objects.
        var view = self.view, size = CGFloat(18), x = CGFloat(44), y = CGFloat(40)
        for i in 0...15{
            let whiteImageView = UIImageView(frame: CGRect(origin: CGPoint(x: x, y:y), size: CGSize(width:size, height:size)))
            
            view?.addSubview(whiteImageView)
            whiteCapturedPieces.append(CapturedPieceImageView(piece: nil, imageView: whiteImageView))
            
            let blackImageView = UIImageView(frame: CGRect(origin: CGPoint(x: x + 355, y:y), size: CGSize(width: size, height: size)))
            view?.addSubview(blackImageView)
            blackCapturedPieces.append(CapturedPieceImageView(piece: nil, imageView: blackImageView))
            
            x += size
            if(i == 7){
                y -= 20
                x = 44
            }
        }
        
        // Lastly, we create the IconSet, populate the chess board, and give values to a few more labels.
        iconSet = IconSet(iconSetName: iconSetName.lowercased())
        self.populateBoard(iconSet!)
        self.currentPlayerTurnLabel.text = whitePlayerName + "'s"
        self.whitePlayerLabel.text = whitePlayerName + " - White"
        self.blackPlayerLabel.text = blackPlayerName + " - Black"
        self.chessGame = globalChessGame
        
        
    }
    
    /**
     Places all pieces on the `Board`.
     
     - Parameter iconSet: The `IconSet` to populate with.
     */
    func populateBoard(_ iconSet: IconSet){
        for i in 0...7{
            boardSpaces[i][1].setPiece(Pawn(image: iconSet.whitePawn, color: .white, enPassantEventHandler: enPassantBlock))
        }
        boardSpaces[0][0].setPiece(Rook(image: iconSet.whiteRook, color: .white))
        boardSpaces[1][0].setPiece(Knight(image: iconSet.whiteKnight, color: .white))
        boardSpaces[2][0].setPiece(Bishop(image: iconSet.whiteBishop, color: .white))
        boardSpaces[3][0].setPiece(Queen(image: iconSet.whiteQueen, pawnImage: nil, color: .white))
        boardSpaces[4][0].setPiece(King(image: iconSet.whiteKing, color: .white))
        boardSpaces[5][0].setPiece(Bishop(image: iconSet.whiteBishop, color: .white))
        boardSpaces[6][0].setPiece(Knight(image: iconSet.whiteKnight, color: .white))
        boardSpaces[7][0].setPiece(Rook(image: iconSet.whiteRook, color: .white))
        
        for i in 0...7{
            boardSpaces[i][6].setPiece(Pawn(image: iconSet.blackPawn, color: .black, enPassantEventHandler: enPassantBlock))
        }
        boardSpaces[0][7].setPiece(Rook(image: iconSet.blackRook, color: .black))
        boardSpaces[1][7].setPiece(Knight(image: iconSet.blackKnight, color: .black))
        boardSpaces[2][7].setPiece(Bishop(image: iconSet.blackBishop, color: .black))
        boardSpaces[3][7].setPiece(Queen(image: iconSet.blackQueen, pawnImage: nil, color: .black))
        boardSpaces[4][7].setPiece(King(image: iconSet.blackKing, color: .black))
        boardSpaces[5][7].setPiece(Bishop(image: iconSet.blackBishop, color: .black))
        boardSpaces[6][7].setPiece(Knight(image: iconSet.blackKnight, color: .black))
        boardSpaces[7][7].setPiece(Rook(image: iconSet.blackRook, color: .black))
    }
}

