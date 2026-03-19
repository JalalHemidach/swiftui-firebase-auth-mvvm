//
//  AuthenticationViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/14/26.
//

import Foundation
import FirebaseAuth

@Observable
class AuthenticationViewModel: SignInProtocol {
    var emailAndPasswordViewModel: EmailAndPasswordViewModel
    var user: User?
    
    var email: String {
        get {
            return emailAndPasswordViewModel.email
        } set {
            emailAndPasswordViewModel.email = newValue
        }
    }
    var password: String {
        get {
            return emailAndPasswordViewModel.password
        } set {
            emailAndPasswordViewModel.password = newValue
        }
    }
    var isAuthenticated: Bool = false
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    
    init() {
        emailAndPasswordViewModel = EmailAndPasswordViewModel(isSignUpScreen: false)
        emailAndPasswordViewModel.signInDelegate = self
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
          DispatchQueue.main.async {
                self?.user = user
                self?.isAuthenticated = user != nil
            }
        }
    }
        
        func signIn(email: String, password: String, Completion: @escaping () -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
              if let error = error {
                    print("Error signing in: \(error.localizedDescription)")
                    return
                }
                print("Signed in successfully")
                Completion()
            }
        }
    
    deinit {
        if let authStateHandle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(authStateHandle)
        }
    }
    
    func clearEmailAndPasswordFields() {
        emailAndPasswordViewModel.clearEmailAndPasswordFields()
    }
}
