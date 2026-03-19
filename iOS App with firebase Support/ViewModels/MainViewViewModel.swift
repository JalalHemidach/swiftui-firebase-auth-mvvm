//
//  MainViewViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/14/26.
//

import Foundation
import FirebaseAuth

@Observable
class MainViewViewModel: EmailAndPasswordValidationViewModel {
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError{
            print("Error signing out: \(signOutError)")
        }
    }
}
