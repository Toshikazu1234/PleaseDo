//
//  LoginVM.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import Foundation
import Observation

@Observable final class LoginVM {
    enum Status {
        case unknown, loggedIn, loggedOut
    }    
    var loginStatus: Status = .unknown
    
    var isLoggingIn = true {
        didSet {
            if isLoggingIn {
                prompt = "Login"
                toggleText = "Don't have an account?"
                toggleButton = "Sign up here"
            } else {
                prompt = "Sign up"
                toggleText = "Already a user?"
                toggleButton = "Login here"
            }
        }
    }
    var prompt = "Login"
    var toggleText = "Don't have an account?"
    var toggleButton = "Sign up here"
    
    var email = ""
    var pw = ""
    
    var fname = ""
    var lname = ""
    var newEmail = ""
    var newPw = ""
    
    func didTapButton() {
        if isLoggingIn {
            
        } else {
            
        }
    }
}
