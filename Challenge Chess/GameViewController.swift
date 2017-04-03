//
//  GameViewController.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 2/17/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import UIKit

var globalChessGame:ChessGame?

class GameViewController: UIViewController {

    @IBOutlet var side1Label: UITextField!
    @IBOutlet var side2Label: UITextField!
    
    @IBOutlet var player1TextField: UITextField!
    @IBOutlet var player2TextField: UITextField!
    
//    @IBOutlet var iconSetPopUpButton: NSPopUpButton!
    @IBOutlet var iconSetPreviewImageView: UIImageView!
    
    var sidesSwitched = false
    
    // The "switch sides" button event handler. Simply switches the color/starting side of each player.
    @IBAction func switchButtonClicked(_ button: UIButton){
        sidesSwitched = !sidesSwitched
        if(sidesSwitched){
            side1Label.text = "Black side"
            side2Label.text = "White side"
            return
        }
        side1Label.text = "White side"
        side2Label.text = "Black side"
    }
    
//    // The icon set chooser popup-button event handler
//    @IBAction func iconSetPopUpAction(_ popUpButton: NSPopUpButton){
//        
//        // Sets the icon set preview image to an image of the selected item's lowercase string, with "_preview" appended
//        iconSetPreviewImageView.image = UIImage(named: "\((popUpButton.selectedItem?.title.lowercased())!)_preview")
//    }
    
    // Holds all active chess games. Without holding a pointer to the new ChessGame object would be immediately deallocated by the garbage collector
    var games = [ChessGame]()
    
    // "Start" button event handler
    @IBAction func startButtonClicked(_ button: UIButton){
        
        // We grab the user-entered player names from their associated text boxes
        var whiteName = player1TextField.text, blackName = player2TextField.text
        
        // If the sides have been switched, then we invert the white and black player name assignments
        if(sidesSwitched){
            whiteName = blackName
            blackName = player1TextField.text
        }
        
        // We create the new ChessGame object with the given parameters, and add it to the ChessGame array.
        globalChessGame = ChessGame(gameType: .humanVsHuman, difficulty: nil, whitePlayerNameParam: whiteName!, blackPlayerNameParam: blackName!, iconSetNameParam: ("maya"))
        games.append(globalChessGame!)
        
//        let storyboard = UIStoryboard(name: "Game", bundle: nil)
//        let gameController = storyboard.instantiateViewController(withIdentifier: "Board") as UIViewController!
//        self.present(gameController!, animated: true, completion: nil)
        performSegue(withIdentifier: "GameToBoard", sender: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
