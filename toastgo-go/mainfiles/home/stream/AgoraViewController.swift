//
//  AgoraViewController.swift
//  toastgo-go
//
//  Created by SAN on 10/20/21.
//

import Foundation
import AgoraRtcKit

class AgoraViewController: UIViewController {

	var agoraKit: AgoraRtcEngineKit?
	var agoraDelegate: AgoraRtcEngineDelegate?
	
	var localView: UIView!
	var remoteView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initializeAgoraEngine()
	}
	
	func initializeAgoraEngine() {
		agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "851193d91b1945bda153a38f3584ead3", delegate: agoraDelegate)
		
		agoraKit?.enableVideo()
		
		// Create a videoCanvas to render the local video
		let videoCanvas = AgoraRtcVideoCanvas()
		videoCanvas.uid = 0
		videoCanvas.renderMode = .hidden
		videoCanvas.view = localView
		agoraKit?.setupLocalVideo(videoCanvas)
		
		agoraKit?.joinChannel(byToken: "Token", channelId: "TestChannel", info: nil, uid: 0, joinSuccess: {(channel, uid, elapsed) in})
	}
	
	func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
		
		let videoCanvas = AgoraRtcVideoCanvas()
		videoCanvas.uid = uid
		videoCanvas.renderMode = .hidden
		videoCanvas.view = remoteView
		agoraKit?.setupRemoteVideo(videoCanvas)
	}
	
//	func joinChannel() {
//		agoraKit?.joinChannel(byToken: "Token", channelId: "TestChannel", info: nil, uid: 0, joinSuccess: {(channel, uid, elapsed) in})
//	}
	
	func leaveChannel() {
		agoraKit?.leaveChannel(nil)
	}
	
	func destroyInstance() {
		AgoraRtcEngineKit.destroy()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		leaveChannel()
		destroyInstance()
	}
	
}
