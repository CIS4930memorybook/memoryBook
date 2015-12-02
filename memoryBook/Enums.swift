//
//  emails.swift
//  MillerCodyAssignment4
//
//  Created by Cody Miller on 10/22/15.
//  Copyright © 2015 Cody Miller. All rights reserved.
//
enum Error: ErrorType{
    case emptyField
    
    case passWordsDoNotMatch
    
    case invalidEmail
    
    case userNameTaken
    
    case inCorrectSignIn
    
    case inValidPassword
    
    case emailTaken
    
    case incorrectSignIn

}

extension Error: CustomStringConvertible{
    var description: String{
        switch self{
        case .emptyField:
                return "Please fill in all fields"
        case .passWordsDoNotMatch:
                return "The passwords do not match"
        case .invalidEmail:
                return "Please enter a valid email"
        case .userNameTaken:
                return "The username is already taken"
        case .inCorrectSignIn:
                return "Your username or password is incorrect"
        case .inValidPassword:
                return "Password must be 8 or more characters ,\n and include a numeric and a capital letter"
        case .emailTaken:
                return "That email has already been registered"
        case .incorrectSignIn:
                return "Your username or password is incorrect"

        }
    }
}