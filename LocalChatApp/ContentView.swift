//
//  ContentView.swift
//  LocalChatApp
//
//  Created by Sumit Pradhan on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                } header: {
                    Text("Connected")
                }
                Section {
                } header: {
                    Text("On my network")
                }
            }
            .navigationTitle("Local Chat")
        }
    }
}

#Preview {
    ContentView()
}
