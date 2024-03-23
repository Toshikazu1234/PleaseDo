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
    func authStateDidChange(_ isLoggedIn: Bool)
}

final class AuthManager {
    weak var delegate: AuthManagerDelegate?
    private let auth = Auth.auth()
    private var handler: AuthStateDidChangeListenerHandle?
    
    private(set) var currentUser: User? {
        didSet {
            delegate?.authStateDidChange(currentUser != nil)
        }
    }
    
    init() {
        handler = auth.addStateDidChangeListener { [weak self] auth, user in
            guard let self else { return }
            guard let user = auth.currentUser else {
                currentUser = nil
                return
            }
            
        }
    }
    
    deinit {
        if let handler {
            auth.removeStateDidChangeListener(handler)
        }
    }
    
    func signIn(_ email: String, _ pw: String) {
        auth.signIn(withEmail: email, password: pw) { [weak self] result, err in
            guard let self, let result else { return }
            currentUser = result.user
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error)
        }
    }
    
    func signUp(_ fname: String, _ lname: String, _ email: String, _ pw: String) {
        Task {
            do {
                let result = try await auth.createUser(withEmail: email, password: pw)
                let id = result.user.uid
                let db = Firestore.firestore()
                let users = db.collection("Users")
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
