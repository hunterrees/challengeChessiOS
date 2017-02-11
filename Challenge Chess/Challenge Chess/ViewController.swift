//
//  ViewController.swift
//  Challenge Chess
//
//  Created by Megan Arnell on 2/8/17.
//  Copyright © 2017 Megan Arnell. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var fbLoginButton: UIButton!
    
    @IBAction func loginButtonClicked(_ sender: AnyObject) {
        
        if let username = usernameInput.text {
            print("Username: " + username)
        }
        
        if let password = passwordInput.text {
            print("Password: " + password)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.current() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let fbLoginButton : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(fbLoginButton)
            fbLoginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 150)
            fbLoginButton.readPermissions = ["public_profile", "email"]
            fbLoginButton.delegate = self

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Facebook Delegate Methods
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if error != nil
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
            graphRequest.start(completionHandler: { (connection, result, error) in
            
            if error != nil
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
//                let userName : NSString = result.value(forKey: "name") as! NSString
//                print("User Name is: \(userName)")
//                let userEmail : NSString = result.value(forKey: "email") as! NSString
//                print("User Email is: \(userEmail)")
            }
        })
    }

    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch UIDevice.current.orientation{
        case .portrait:
            fbLoginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 150)
        case .portraitUpsideDown:
            fbLoginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 150)
        case .landscapeLeft:
            fbLoginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 50)
        case .landscapeRight:
            fbLoginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 50)
        default:
            fbLoginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 150)
        }
    }

}

