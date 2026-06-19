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
    weak var signUpDelegate: SignUpProtocol?
    
    //MARK: init
    init() {
        emailAndPasswordViewModel = EmailAndPasswordViewModel(isSignInScreen: false)
        emailAndPasswordViewModel.signUpDelegate = self
    }
    
    //MARK: SignUp
    func signUp(email: String, password: String, completion: @escaping () -> Void) {
        signUpDelegate?.signUp(email: email, password: password) {
            completion()
        }
    }
    
    //MARK: Should Display SignUp Screen
    func shouldDisplaySignUpScreenToggle() {
        signUpDelegate?.shouldDisplaySignUpScreenToggle()
    }
    
    //MARK: Should Display Authentication Error Messages
    func shouldDisplayAuthenticationErrorMessage(_ decision: Bool) {
        emailAndPasswordViewModel.shouldDisplayAuthenticationErrorMessage = decision
    }
    
    //MARK: Setting Error Messages
    func setAuthenticationErrorMessage(_ errorMessage: String) {
        emailAndPasswordViewModel.authenticationErrorMessage = errorMessage
    }
}
