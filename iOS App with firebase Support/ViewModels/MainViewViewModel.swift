//
//  MainViewViewModel.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/14/26.
//

import Foundation

@Observable
class MainViewViewModel {
    //MARK: Delegates
    weak var signOutDelegate: SignOutProtocol?

    //MARK: Sign-Out
    func signOut() {
        signOutDelegate?.signOut()
    }
}
