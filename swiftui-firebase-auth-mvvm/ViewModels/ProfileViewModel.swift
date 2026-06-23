//
//  ProfileViewModel.swift
//  swiftui-firebase-auth-mvvm
//
//  Created by Jalal Hemidach on 3/14/26.
//

import Foundation

@Observable
class ProfileViewModel {
    //MARK: Delegates
    weak var signOutDelegate: SignOutProtocol?

    //MARK: Sign-Out
    func signOut() {
        signOutDelegate?.signOut()
    }
}
