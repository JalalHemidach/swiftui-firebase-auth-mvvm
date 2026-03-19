//
//  EmailAndPasswordValidationViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/16/26.
//

import Foundation

@Observable
class EmailAndPasswordValidationViewModel {
    //MARK: Properties
    var email = ""
    var password = ""
    var confirmPassword = ""
    
    //MARK: Email Validation
    func isValidEmail() -> Bool {
        let regex = try! Regex("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")
        return email.wholeMatch(of: regex) != nil
    }
    
    //MARK: Password Validation
    func isValidPassword() -> Bool {
        let regex = try! Regex("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{8,}$")
        return password.wholeMatch(of: regex) != nil
    }
    
    //MARK: Email & Password Validation
    func isValidEmailAndPassword() -> Bool {
        return isValidEmail() && isValidPassword()
    }
}
