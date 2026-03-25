//
//  AuthenticationView.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/14/26.
//

import SwiftUI

let kFirebaseColor: Color = Color(
    red: 245 / 255,
    green: 130 / 255,
    blue: 13 / 255
)
struct AuthenticationView: View {
    @State private var authenticationViewModel = AuthenticationViewModel()

    var body: some View {
        VStack {
            Spacer()

            //MARK: Screen Header
            Label("iOS APP & FIREBASE", image: "")
                .font(Font.title.bold())
                .foregroundStyle(.primary)

            Spacer()

            //MARK: Screen Logos
            HStack {
                Image("ios-logo")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .border(.primary)

                Image("firebase-logo")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .border(.primary)
            }

            Spacer()
            Spacer()

            //MARK: SignIn With Apple Button
            SignInWithAppleView()

            //MARK: SignIn With Google Button
            SignInWithGoogleView()
            
            //MARK: Horizontal (- OR -) Separator
            horizontalSeparatorView()

            //MARK: Email & Password View
            EmailAndPasswordView(
                emailAndPasswordViewModel: authenticationViewModel
                    .emailAndPasswordViewModel
            )

            Spacer()
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $authenticationViewModel.isAuthenticated, content: {
            MainView(signOutDelegate: authenticationViewModel.self)
        })
        .sheet(isPresented: $authenticationViewModel.shouldDisplaySignUpScreen) {
            SignUpView(signUpDelegate: authenticationViewModel.self)
        }
    }

    fileprivate func horizontalSeparatorView() -> some View {
        return
            HStack {
                VStack { Divider() }
                Text("OR")
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                VStack { Divider() }
            }
    }
}

#Preview {
    AuthenticationView()
}
