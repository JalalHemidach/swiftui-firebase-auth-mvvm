//
//  SignUpView.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/16/26.
//

import SwiftUI

struct SignUpView: View {
    //MARK: @State
    @State private var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            //MARK: First Name
            HStack {
                Label("First Name", systemImage: "person.text.rectangle")
                    .foregroundColor(.primary)
            }
            TextField("First Name", text: $signUpViewModel.firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            //MARK: Last Name
            Label("Last Name", systemImage: "person.text.rectangle.fill")
            TextField("Last Name (Optional)", text: $signUpViewModel.lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            //MARK: Email & Password View`
            EmailAndPasswordView(emailAndPasswordViewModel: signUpViewModel.emailAndPasswordViewModel)
        }
    }
}

#Preview {
    SignUpView()
}
