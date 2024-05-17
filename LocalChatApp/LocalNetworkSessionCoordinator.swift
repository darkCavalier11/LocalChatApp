//
//  LocalNetworkSessionCoordinator.swift
//  LocalChatApp
//
//  Created by Sumit Pradhan on 17/05/24.
//

import Foundation
import MultipeerConnectivity

@Observable
class LocalNetworkSessionCoordinator: NSObject {
    private let advertiser: MCNearbyServiceAdvertiser
    private let browser: MCNearbyServiceBrowser
    private let session: MCSession
    
    private(set) var availableDevices: Set<MCPeerID> = []
    
    init(peerID: MCPeerID = .init(displayName: UIDevice.current.name)) {
        advertiser = .init(
            peer: peerID,
            discoveryInfo: nil,
            serviceType: .messageSendingService
        )
        browser = .init(
            peer: peerID,
            serviceType: .messageSendingService
        )
        session = .init(peer: peerID)
        super.init()
        
        browser.delegate = self
        advertiser.delegate = self
    }
    
    public func startAdvertising() {
        advertiser.startAdvertisingPeer()
    }
    
    public func stopAdvertising() {
        advertiser.stopAdvertisingPeer()
    }
    
    public func startBrowsing() {
        browser.startBrowsingForPeers()
    }
    
    public func stopBrowing() {
        browser.stopBrowsingForPeers()
    }
}

extension LocalNetworkSessionCoordinator: MCNearbyServiceAdvertiserDelegate {
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        invitationHandler(true, session)
    }
}

extension LocalNetworkSessionCoordinator: MCNearbyServiceBrowserDelegate {
    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID,
        withDiscoveryInfo info: [String : String]?
    ) {
        availableDevices.insert(peerID)
    }
    
    func browser(
        _ browser: MCNearbyServiceBrowser,
        lostPeer peerID: MCPeerID
    ) {
        availableDevices.remove(peerID)
    }
    
}

private extension String {
    static let messageSendingService = "sendMessage"
}
