//
//  SignInWithAppleView.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/17/26.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
    
    var body: some View {
        //MARK: SignIn With Apple Button
        SignInWithAppleButton(
            .signIn,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Auth Success!: \(authResults)")
                case .failure(let error):
                    print("Auth Failed: \(error.localizedDescription)")
                    print(
                        "⚠️ You Cannot Sign In With Apple If You Are Not a Member of The Apple Developer Program!"
                    )
                }
            }
        )
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
}

#Preview {
    SignInWithAppleView()
}
