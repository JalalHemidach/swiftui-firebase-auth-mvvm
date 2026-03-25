//
//  SignUpViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/16/26.
//

import Foundation

@Observable
class SignUpViewModel: SignUpProtocol {
    //MARK: Properties
    var emailAndPasswordViewModel: EmailAndPasswordViewModel
    var firstName = ""
    var lastName = ""
    var confirmPassword = ""
    
    //MARK: Delegates
    var signUpDelegate: SignUpProtocol?
    
    //MARK: init
    init() {
        emailAndPasswordViewModel = EmailAndPasswordViewModel(isSignInScreen: false)
        emailAndPasswordViewModel.signUpDelegate = self
    }
    
    //MARK: SignUp
    func signUp(email: String, password: String, Completion: @escaping () -> Void) {
        signUpDelegate?.signUp(email: email, password: password) {
            Completion()
        }
    }
    
    func shouldDisplaySignUpScreenToggle() {
        signUpDelegate?.shouldDisplaySignUpScreenToggle()
    }
}
