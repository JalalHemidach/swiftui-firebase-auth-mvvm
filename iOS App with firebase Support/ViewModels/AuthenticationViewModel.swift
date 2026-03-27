//
//  AuthenticationViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/14/26.
//

import Foundation
import FirebaseAuth
import Observation

//MARK: SignIn Protocol
protocol SignInProtocol: AnyObject {
    func signIn(email: String, password: String, completion: @escaping () -> Void)
    func shouldDisplaySignUpScreenToggle()
}

//MARK: SignUp Protocol
protocol SignUpProtocol: AnyObject {
    func signUp(email: String, password: String, completion: @escaping () -> Void)
    func shouldDisplaySignUpScreenToggle()
}

//MARK: Sign-Out Protocol
protocol SignOutProtocol: AnyObject {
    func signOut()
}

//MARK: Class
@Observable
class AuthenticationViewModel: SignInProtocol, SignUpProtocol, SignOutProtocol {
    //MARK: Properties
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
    
    var shouldDisplaySignUpScreen: Bool = false
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    //MARK: Delegates
    weak var signUpDelegate: SignUpProtocol?
    
    //MARK: init
    init() {
        emailAndPasswordViewModel = EmailAndPasswordViewModel(isSignInScreen: true)
        emailAndPasswordViewModel.signInDelegate = self
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
          DispatchQueue.main.async {
                self?.user = user
                self?.isAuthenticated = user != nil
            }
        }
    }
    
    //MARK: Sign-In
    func signIn(email: String, password: String, completion: @escaping () -> Void) {
        //MARK: email & password validation
        if emailAndPasswordViewModel.isValidEmailAndPassword(email: email, password: password) {
            //MARK: Firebase Authentication (SignIn)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
              if let error = error {
                  self.emailAndPasswordViewModel.shouldDisplayInvalidEmailOrPasswordWarningMessages = true
                  print("Error signing in: \(error.localizedDescription)")
                  return
                }
                self.emailAndPasswordViewModel.shouldDisplayInvalidEmailOrPasswordWarningMessages = false
                print("Signed in successfully")
                completion()
            }
        }
    }
    
    func shouldDisplaySignUpScreenToggle() {
        shouldDisplaySignUpScreen.toggle()
    }
    
    //MARK: Sign-Up
    func signUp(email: String, password: String, completion: @escaping () -> Void) {
        if emailAndPasswordViewModel.isValidEmailAndPassword(email: email, password: password) {
            //MARK: Firebase Create user (SignUp)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Error signing up: \(error.localizedDescription)")
                    return
                }
                print("Signed up successfully")
                completion()
            }
        }
    }
    
    //MARK: Sign-Out
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError{
            print("Error signing out: \(signOutError)")
        }
    }
    
    //MARK: deinit
    deinit {
        if let authStateHandle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(authStateHandle)
        }
    }
    
    //MARK: Clear email & Password Fields
    func clearEmailAndPasswordFields() {
        emailAndPasswordViewModel.clearEmailAndPasswordFields()
    }
}
