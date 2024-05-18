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
                    ForEach(Array(localNetwork.connectedDevices), id: \.self) { peerID in
                        HStack {
                            Text(peerID.displayName)
                            Spacer()
                            Button {
                                
                            } label: {
                                Image(systemName: "paperplane")
                            }
                        }
                    }
                } header: {
                    Text("Connected")
                }
                Section {
                    ForEach(Array(localNetwork.otherDevices), id: \.self) { peerID in
                        HStack {
                            Text(peerID.displayName)
                            Spacer()
                            Button {
                                localNetwork.invitePeer(peerID: peerID)
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
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
