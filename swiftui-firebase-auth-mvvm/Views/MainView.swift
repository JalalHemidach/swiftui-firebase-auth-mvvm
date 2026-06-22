//
//  MainView.swift
//  swiftui-firebase-auth-mvvm
//
//  Created by Jalal Hemidach on 3/14/26.
//

import SwiftUI

struct MainView: View {
    @State private var mainViewModel = MainViewModel()
    
    //MARK: init
    init(signOutDelegate: SignOutProtocol) {
        mainViewModel.signOutDelegate = signOutDelegate
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
                        mainViewModel.signOut()
                    } label: {
                        Image(systemName: "rectangle.righthalf.inset.filled.arrow.right")
                    }
                }
            }
        }
    }
}

#Preview {
    MainView(signOutDelegate: MainViewModel().signOutDelegate!)
}
