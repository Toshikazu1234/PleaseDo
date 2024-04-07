//
//  AuthManager.swift
//  PleaseDo
//
//  Created by R K on 3/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthManagerDelegate: AnyObject {
    func authStateDidChange(isLoggedIn: Bool)
}

final class AuthManager {
    weak var delegate: AuthManagerDelegate?
    
    private let usersCollection = "Users"
    private let auth = Auth.auth()
    private var handler: AuthStateDidChangeListenerHandle?
    
    private(set) var currentUser: User? {
        didSet {
            delegate?.authStateDidChange(isLoggedIn: currentUser != nil)
        }
    }
    
    init() {
        if let user = auth.currentUser {
            currentUser = user
        }
        setupListener()
    }
    
    deinit {
        removeListener()
    }
    
    func signIn(_ email: String, _ pw: String) {
        auth.signIn(withEmail: email, password: pw) { [weak self] result, err in
            guard let self, let result else { return }
            currentUser = result.user
            print("Successfully signed in user!")
            setupListener()
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            currentUser = nil
            removeListener()
            print("Successfully signed out user!")
        } catch {
            print(error)
        }
    }
    
    private func setupListener() {
        guard handler == nil else { return }
        handler = auth.addStateDidChangeListener { [weak self] auth, user in
            guard let self else { return }
            if auth.currentUser == nil {
                currentUser = nil
                return
            }
            if let user = auth.currentUser, let currentUser, user.uid != currentUser.uid {
                signOut()
            }
        }
    }
    
    private func removeListener() {
        if let h = handler {
            auth.removeStateDidChangeListener(h)
        }
    }
    
    func signUp(_ fname: String, _ lname: String, _ email: String, _ pw: String) {
        Task {
            do {
                let result = try await auth.createUser(withEmail: email, password: pw)
                let id = result.user.uid
                let db = Firestore.firestore()
                let users = db.collection(usersCollection)
                try await users.document(id).setData([
                    "fname": fname,
                    "lname": lname,
                    "email": email
                ])
                currentUser = result.user
                print("Successfully created user!")
            } catch {
                print(error)
            }
        }
    }
}
