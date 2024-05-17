//
//  ContentView.swift
//  LocalChatApp
//
//  Created by Sumit Pradhan on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var localNetwork = LocalNetworkSessionCoordinator()
    var body: some View {
        NavigationStack {
            List {
                Section {
                } header: {
                    Text("Connected")
                }
                Section {
                    ForEach(Array(localNetwork.availableDevices), id: \.self) { peerID in
                        Text(peerID.displayName)
                    }
                } header: {
                    Text("On my network")
                }
            }
            .navigationTitle("Local Chat")
        }
        .onAppear {
            localNetwork.startBrowsing()
            localNetwork.startAdvertising()
        }
        .onDisappear {
            localNetwork.stopBrowing()
            localNetwork.stopAdvertising()
        }
    }
}

#Preview {
    ContentView()
}
