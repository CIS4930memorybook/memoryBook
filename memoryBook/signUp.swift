//
//  signUp.swift
//  MillerCodyAssignment4
//
//  Created by Cody Miller on 10/22/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//
import Parse

class signUp: NSObject {
    var firstName: String?
    var lastName: String?
    var email: String?
    var username: String?
    var password: String?
    var confirmPassword: String?
    
    init(fName: String, lName: String, mail: String, uName: String, pass: String, conPass: String){
        self.firstName = fName
        self.lastName = lName
        self.email = mail
        self.username = uName
        self.password = pass
        self.confirmPassword = conPass
        
    }
    
    func signUpUser() throws -> Bool{
            
            // when using throws above you will write guard the function name then else with an error that is thrown if your function returns false. Each error below is called from our Enums model.
            guard hasEmptyFields() else {
                throw Error.emptyField
            }
            
            guard isValidEmail() else {
                throw Error.invalidEmail
            }
            
            guard validatePasswordsMatch() else {
                throw Error.passWordsDoNotMatch
            }
            
            guard checkSufficientPassword() else {
                throw Error.inValidPassword
            }
            
            guard storeSuccessfulSignup() else {
                throw Error.userNameTaken
            }
            return true
        }
    
    func hasEmptyFields() -> Bool {
        if !firstName!.isEmpty && !lastName!.isEmpty && !email!.isEmpty && !username!.isEmpty && !password!.isEmpty && !confirmPassword!.isEmpty{
            return true
        }
        return false
    }
    
    func isValidEmail() -> Bool{
        let emailEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]"
        let range = email!.rangeOfString(emailEx, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    func validatePasswordsMatch() -> Bool{
        if(password == confirmPassword!){
            return true
        }
        return false
    }
    
    func checkSufficientPassword() -> Bool {
        let CapitalLetterRegEx = ".*[A-Z]+.*"
        let textTest = NSPredicate(format: "SELF MATCHES %@", CapitalLetterRegEx)
        let CapitalResult = textTest.evaluateWithObject(password!)
        print("Capital Letter: \(CapitalResult)")
        
        let NumberRegEx = ".*[0-9]+.*"
        let textTest2 = NSPredicate(format: "SELF MATCHES %@", NumberRegEx)
        let NumberResult = textTest2.evaluateWithObject(password!)
        print("Number Included: \(NumberResult)")
        
        let lengthResult = password!.characters.count >= 8
        print("Passed Length: \(lengthResult)")
        
        return CapitalResult && NumberResult && lengthResult
        
    }
    
    func storeSuccessfulSignup() -> Bool{
        var success = false;
        let user = PFUser()
        user["FirstName"] = firstName!
        user["lastName"] = lastName!
        user.username = username!
        user.email = email!
        user.password = password!
        do {
            try user.signUp()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            
        }
       
        success = user.isNew
        return success
    }
    
}