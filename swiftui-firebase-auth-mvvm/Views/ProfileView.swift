//
//  ProfileView.swift
//  swiftui-firebase-auth-mvvm
//
//  Created by Jalal Hemidach on 3/14/26.
//

import SwiftUI

struct ProfileView: View {
    @State private var profileViewModel = ProfileViewModel()
    
    //MARK: init
    init(signOutDelegate: SignOutProtocol) {
        profileViewModel.signOutDelegate = signOutDelegate
    }
    
    var body: some View {
        NavigationStack {
            List {
                Text("Hello, World!")
            }
            .navigationTitle("Main View")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        profileViewModel.signOut()
                    } label: {
                        Image(systemName: "rectangle.righthalf.inset.filled.arrow.right")
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView(signOutDelegate: ProfileViewModel().signOutDelegate!)
}
