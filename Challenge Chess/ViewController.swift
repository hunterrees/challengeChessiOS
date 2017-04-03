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
        
//        if (FBSDKAccessToken.current() != nil)
//        {
//            //self.performSegue(withIdentifier: "redirectAfterFacebookLogin", sender: self)
//            print("User Logged In")
//            
//        }
//        else
//        {
            let fbLoginButton : FBSDKLoginButton = FBSDKLoginButton()
            
            fbLoginButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 150)
            
            fbLoginButton.readPermissions = ["public_profile", "email"]
            
            fbLoginButton.delegate = self
            
            self.view.addSubview(fbLoginButton)
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Facebook Delegate Methods
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        
        if error != nil
        {
           print("Error logging in through Facebook")
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
                print("User Logged In")
                self.performSegue(withIdentifier: "redirectAfterFacebookLogin", sender: self)
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }


}

