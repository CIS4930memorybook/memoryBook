//
//  signUpViewController.swift
//  MillerCodyAssignment4
//
//  Created by Cody Miller on 10/22/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//

import UIKit
import Parse
class signUpController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorOutput: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        username.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
    }
    
    @IBAction func signUpTouched(sender: UIButton) {
        errorOutput.text = ""
        let signup = signUp(fName: firstName.text!, lName: lastName.text!, mail: email.text!, uName: username.text!, pass: password.text!, conPass: confirmPassword.text!)
        do{
            try signup.signUpUser()
            let alert = signUpSuccessAlert()
            presentViewController(alert, animated: true, completion: nil)
        }catch let error as Error{
            errorOutput.text = error.description
        } catch
        { errorOutput.text = "Sorry something went wrong. Please try again"
        }
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func signUpSuccessAlert() -> UIAlertController{
        let alertview = UIAlertController(title: "Sign up successful", message: "Now you can log in for complete access", preferredStyle: .Alert)
        alertview.addAction(UIAlertAction(title: "Login", style: .Default, handler: {(alertaction) -> Void in self.dismissViewControllerAnimated(true, completion: nil)}))
        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        return alertview
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
