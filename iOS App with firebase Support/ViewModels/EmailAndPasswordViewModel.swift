//
//  EmailAndPasswordViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/16/26.
//

import Foundation

//MARK: Class
@Observable
class EmailAndPasswordViewModel {
    //MARK: Properties
    var email = ""
    var password = ""
    var confirmPassword = ""
    var isPasswordVisible: Bool = false
    var isEmailAndPasswordToggleChecked = false
    var shouldDisplayInvalidEmailOrPasswordWarningMessages: Bool = false
    var isSignInScreen: Bool
    
    //MARK: Delegates
    var signInDelegate: SignInProtocol?
    var signUpDelegate: SignUpProtocol?
    
    //MARK: init
    init(isSignInScreen: Bool) {
        self.isSignInScreen = isSignInScreen
    }
    
    //MARK: Email Validation
    func isValidEmail(email: String) -> Bool {
        let regex = try! Regex("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")
        return email.wholeMatch(of: regex) != nil
    }
    
    //MARK: Password Validation
    func isValidPassword(password: String) -> Bool {
        let regex = try! Regex("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$")
        return password.wholeMatch(of: regex) != nil
    }
    
    //MARK: Email & Password Validation -> Bool
    func isValidEmailAndPassword(email: String, password: String) -> Bool {
        return isValidEmail(email: email) && isValidPassword(password: password)
    }
                
    //MARK: Email & Password Validation
//    func isValidEmailAndPassword(email: String, password: String) {
//        guard isValidEmailAndPassword(email: email, password: password) else {
//            shouldDisplayInvalidEmailOrPasswordWarningMessages = true
//            return
//        }
//        shouldDisplayInvalidEmailOrPasswordWarningMessages = false
//    }
    
    //MARK: Passwords Do NOT Match
    func passwordsDoNotMatch(password: String, confirmPassword: String) -> Bool {
        return password != confirmPassword
    }
    
    //MARK: Perform Action
    func performAction(completion: @escaping () -> Void) {
        switch isSignInScreen {
            case true:
            signInDelegate?.signIn(email: email, password: password, completion: {
                completion()
            })
            case false:
                self.signUpDelegate?.shouldDisplaySignUpScreenToggle()
            signUpDelegate?.signUp(email: email, password: password, completion: {
                completion()
            })
        }
    }
    
    //MARK: Clear Email & Password
    
    func clearEmailAndPasswordFields() {
        self.email = ""
        self.password = ""
    }
}
