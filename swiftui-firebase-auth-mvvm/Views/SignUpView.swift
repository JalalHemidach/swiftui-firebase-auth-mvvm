//
//  SignUpView.swift
//  swiftui-firebase-auth-mvvm
//
//  Created by Jalal Hemidach on 3/16/26.
//

import SwiftUI

struct SignUpView: View {
    //MARK: @State
    @State private var signUpViewModel = SignUpViewModel()
    
    
    init(signUpDelegate: SignUpProtocol) {
        signUpViewModel.signUpDelegate = signUpDelegate
        if let loginViewModel = signUpDelegate as? LoginViewModel {
            loginViewModel.signUpDelegate = signUpViewModel
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            //MARK: First Name
            Label("First Name", systemImage: "person.text.rectangle")
            TextField("First Name (Optional)", text: $signUpViewModel.firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            //MARK: Last Name
            Label("Last Name", systemImage: "person.text.rectangle.fill")
            TextField("Last Name (Optional)", text: $signUpViewModel.lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            //MARK: Email & Password View
            EmailAndPasswordView(emailAndPasswordViewModel: signUpViewModel.emailAndPasswordViewModel)
        }
        .padding()
    }
}

#Preview {
    SignUpView(signUpDelegate: SignUpViewModel().signUpDelegate!)
}
