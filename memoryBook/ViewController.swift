//
//  ViewController.swift
//  memoryBook
//
//  Created by Cody Miller on 10/16/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // textField variables
    @IBOutlet private weak var username: UITextField!
    @IBOutlet private weak var password: UITextField!
    
    @IBOutlet weak var errorOutput: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegate variables
        username.delegate = self
        password.delegate = self
    }
    
    // Sign In button
    @IBAction func signInTouched(sender: UIButton) {
        // initialize SignIn model and pass in variables
        let signin = SignIn(user: username.text!, pass: password.text!)
        
        do {
            // call signIn model function SignInUser()
            // anything under this try will execute if signInUser returns true
            try signin.signInUser()
            
            // dismiss view controller and go to MainViewController
            self.dismissViewControllerAnimated(true, completion: nil)
            
            // catches error thrown by SignInUser() if there is one
        } catch let error as Error {
            errorOutput.text = error.description
        } catch {
            errorOutput.text = "Sorry something went\n wrong please try again"
        }
        
    }
    
    // Dismiss keyboard if user touches the background area
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

