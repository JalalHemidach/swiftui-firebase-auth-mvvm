//
//  EmailAndPasswordViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/16/26.
//

import Foundation

//MARK: Email & Password Protocol
protocol SignInProtocol {
    func signIn(email: String, password: String, Completion: @escaping () -> Void)
    var isAuthenticated: Bool { get set }
}

//MARK: Class
@Observable
class EmailAndPasswordViewModel: EmailAndPasswordValidationViewModel {
    //MARK: Properties
    var isPasswordVisible: Bool = false
    var isEmailAndPasswordToggleChecked = false
    var shouldDisplayInvalidEmailOrPasswordWarningMessages: Bool = false
    var isSignUpScreen: Bool
    var isAuthenticated: Bool {
        get {
            signInDelegate?.isAuthenticated ?? false
        }
        set {
            signInDelegate?.isAuthenticated = newValue
        }
    }
    var shouldDisplaySignUpScreen: Bool
//    var shouldDisplaySignUpScreen: Bool {
//        get {
//            signUpDelegate?.shouldDisplaySignUpScreen ?? false
//        }
//        set {
//            signUpDelegate?.shouldDisplaySignUpScreen = newValue
//        }
//    }
    
    //MARK: Delegates
    var signInDelegate: SignInProtocol?
    var signUpDelegate: SignUpProtocol?
    
    //MARK: init
    init(isSignUpScreen: Bool) {
        self.isSignUpScreen = isSignUpScreen
        shouldDisplaySignUpScreen = false
    }
    
    //MARK: SignIn
    func signIn(email: String, password: String, Completion: @escaping () -> Void) {
        guard isValidEmailAndPassword() else {
            shouldDisplayInvalidEmailOrPasswordWarningMessages = true
            return
        }
        signInDelegate?.signIn(email: email, password: password) {
            Completion()
        }
    }
    
    //MARK: SignUp
    //FIXME: SignUp logic and credential validation
    func signUp(email: String, password: String, Completion: @escaping () -> Void) {
        guard isValidEmailAndPassword() else {
            shouldDisplayInvalidEmailOrPasswordWarningMessages = true
            return
        }
        signUpDelegate?.signUp(email: email, password: password) {
            Completion()
        }
    }
    
    //FIXME: Perform Action
    func performAction(action: @escaping () -> Void) {
        switch isSignUpScreen {
            case true:
            print("true")
//            signUp(email: email, password: password, Completion: {
//                action()
//            })
        case false:
            signIn(email: email, password: password, Completion: {
                action()
            })
        }
    }
    
    //MARK: Clear Email & Password
    
    func clearEmailAndPasswordFields() {
        self.email = ""
        self.password = ""
    }
}
