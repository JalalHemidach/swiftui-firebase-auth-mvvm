//
//  SignUpViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/16/26.
//

import Foundation
import FirebaseAuth

protocol SignUpProtocol {
    func signUp(email: String, password: String, Completion: @escaping () -> Void)
    var shouldDisplaySignUpScreen: Bool { get set }
}
@Observable
class SignUpViewModel: SignUpProtocol {
    //MARK: Properties
    var emailAndPasswordViewModel: EmailAndPasswordViewModel
    var firstName = ""
    var lastName = ""
    var confirmPassword = ""
    var shouldDisplaySignUpScreen: Bool
    
    //MARK: init
    init() {
        emailAndPasswordViewModel = EmailAndPasswordViewModel(isSignUpScreen: true)
        shouldDisplaySignUpScreen = false
//        emailAndPasswordViewModel.signUpDelegate = self
    }
    
    //MARK: SignUp
    func signUp(email: String, password: String, Completion: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error signing up: \(error.localizedDescription)")
                return
            }
            print("Signed up successfully")
            Completion()
        }
    }
}
