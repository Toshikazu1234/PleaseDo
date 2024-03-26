//
//  LoginVM.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import Foundation

final class LoginVM: ObservableObject {
    private let auth = AuthManager()
        
    enum Status {
        case unknown, loggedIn, loggedOut
    }    
    @Published var loginStatus: Status = .unknown
    
    @Published var isLoggingIn = true {
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
    @Published var prompt = "Login"
    @Published var toggleText = "Don't have an account?"
    @Published var toggleButton = "Sign up here"
    
    @Published var email = ""
    @Published var pw = ""
    
    @Published var fname = ""
    @Published var lname = ""
    @Published var newEmail = ""
    @Published var newPw = ""
    
    /// Because `AuthManager` property may initialize before `self` is finished initializing and before `auth.delegate` is set to `self`, we need to check `auth.currentUser` to set the `loginStatus`.
    init() {
        auth.delegate = self
        loginStatus = auth.currentUser != nil ? .loggedIn : .loggedOut
    }
    
    func didTapButton() {
        if isLoggingIn {
            auth.signIn(email, pw)
        } else {
            auth.signUp(fname, lname, newEmail, newPw)
        }
    }
    
    func signOut() {
        auth.signOut()
    }
}

extension LoginVM: AuthManagerDelegate {
    func authStateDidChange(isLoggedIn: Bool) {
        loginStatus = isLoggedIn ? .loggedIn : .loggedOut
    }
}
