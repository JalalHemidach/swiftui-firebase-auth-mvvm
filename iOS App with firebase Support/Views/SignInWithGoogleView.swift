//
//  SignInWithGoogleView.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/17/26.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInWithGoogleView: View {
    
    var body: some View {
        //MARK: SignIn With Google Button
        GoogleSignInButton(scheme: .dark, style: .wide, state: .normal, action: {
            print("☑️ Google Sign In")
        })
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}
