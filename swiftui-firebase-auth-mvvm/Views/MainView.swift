//
//  MainView.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/14/26.
//

import SwiftUI

struct MainView: View {
    @State private var mainViewViewModel = MainViewViewModel()
    
    //MARK: init
    init(signOutDelegate: SignOutProtocol) {
        mainViewViewModel.signOutDelegate = signOutDelegate
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
                        mainViewViewModel.signOut()
                    } label: {
                        Image(systemName: "rectangle.righthalf.inset.filled.arrow.right")
                    }
                }
            }
        }
    }
}

#Preview {
    MainView(signOutDelegate: MainViewViewModel().signOutDelegate!)
}
