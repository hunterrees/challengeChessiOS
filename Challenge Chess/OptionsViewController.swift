//
//  OptionsViewController.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 2/17/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import UIKit

var board_type = "classic"
var piece_type = "classic"

class OptionsViewController: UIViewController {
    
    var tagOfSelectedBoard = 7
    var tagOfSelectedPiece = 10

    @IBAction func boardButtonPressed(_ sender: AnyObject) {
        
        var newTag = 0
        
        if sender.tag == 1 {
            board_type = "classic"
            newTag = 7
        }
        if sender.tag == 2 {
            board_type = "retro"
            newTag = 8
        }
        if sender.tag == 3 {
            newTag = 9
            board_type = "ancient"
        }
        
        if let highlightImage = self.view.viewWithTag(newTag) as? UIImageView {
            highlightImage.image = UIImage(named: "highlighted_square.png")
        }
        
        if let highlightImage = self.view.viewWithTag(tagOfSelectedBoard) as? UIImageView {
            highlightImage.image = UIImage(named: "")
        }
        
        tagOfSelectedBoard = newTag
        
    }
    
    @IBAction func piecesButtonPressed(_ sender: AnyObject) {
        
        var newTag = 0
        
        if sender.tag == 4 {
            board_type = "classic"
            newTag = 10
        }
        if sender.tag == 5 {
            board_type = "mayan"
            newTag = 11
        }
        if sender.tag == 6 {
            board_type = "noble"
            newTag = 12
        }
        
        if let highlightImage = self.view.viewWithTag(newTag) as? UIImageView {
            highlightImage.image = UIImage(named: "highlighted_square.png")
        }
        
        if let highlightImage = self.view.viewWithTag(tagOfSelectedPiece) as? UIImageView {
            highlightImage.image = UIImage(named: "")
        }
        
        tagOfSelectedPiece = newTag
        
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
