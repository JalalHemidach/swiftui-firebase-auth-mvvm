//
//  AuthenticationView.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/14/26.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Label("iOS App & Firebase", image: "")
                .font(Font.title.bold())
                .foregroundStyle(Color(red: 245/255, green: 130/255, blue: 13/255))
            
            Spacer()
            
            HStack {
                Image("ios-logo")
                    .resizable()
                    .frame(width: 180, height: 180)

                Image("firebase-logo")
                    .resizable()
                    .frame(width: 180, height: 180)
            }
            
            Spacer()
            Spacer()
        
            Group {
                HStack{
                    Label("Email:     ", systemImage: "envelope")
                    TextField("Enter your email..", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Label("Password:", systemImage: "lock")
                    TextField("Enter your password..", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .foregroundStyle(Color.blue)
            
            Button {
                //action
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(10)
            
            Spacer()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AuthenticationView()
}
