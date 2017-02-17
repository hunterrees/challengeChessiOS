//
//  MenuViewController.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 2/15/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let levels = [1,2,3,4,5]
    var selectedLevel = 1
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var levelPicker: UIPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        levelView.isHidden = true;
        levelPicker.isHidden = true;
        
        levelView.layer.cornerRadius = 10
        
        levelPicker.delegate = self
        levelPicker.dataSource = self
    }
    
    @IBAction func endLevelSelectionClicked(_ sender: Any) {
        
        selectedLevel = levels[levelPicker.selectedRow(inComponent: 0)]
        levelView.isHidden = true
        levelPicker.isHidden = true 
        
    }
    
    @IBAction func versusButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Enter opponent username", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil))
        alert.addTextField { (configurationTextField) in
            //configure here your textfield
        }
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            print("Done !!")
            if let textField = alert.textFields?.first {
                print("Opponent username : \(textField.text))")
            }
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
    @IBAction func computerButtonClicked(_ sender: Any) {
        
        levelView.isHidden = false;
        levelPicker.isHidden = false;

    }
    
    @IBAction func learningButtonClicked(_ sender: Any) {
    }
    
    @IBAction func optionsButtonClicked(_ sender: Any) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(levels[row])
    }
    
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return levels.count
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
