//
//  MainView.swift
//  iOS App with firebase Support
//
//  Created by Jalal Hemidach on 3/14/26.
//

import SwiftUI

struct MainView: View {
    @State private var viewModel = MainViewViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Text("Hello, World!")
            }
            .navigationTitle("Main View")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.signOut()
                    } label: {
                        Image(systemName: "rectangle.righthalf.inset.filled.arrow.right")
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
