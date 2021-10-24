//
//  ScreenStreamScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import SwiftUI
import SwiftUIKitView
import AgoraRtcKit
import SwiftUIFontIcon

struct ScreenStreamScreen: View {
	
	@StateObject private var viewModel = ScreenStreamViewModel()
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	var clubName: String     // in directs, its the other user's name
	var clubId: Int 			// in directs, its the other user's id
	var channelId: String
	var ongoingFrame: Bool
	var startTime: String
	var endTime: String
	var ongoingStream: Bool
	var ongoingStreamUser: String
	var directornot: Bool
	
	var my_id: Int
	var my_name: String
	
	var agora_token: String
	
	@State var isLocalInSession = false
	@State var isLocalAudioMuted = false
	
	@State var isRemoteInSession = false
	@State var isRemoteVideoMuted = true
	
	let localCanvas = ScreenStreamVideoCanvas()
	let remoteCanvas = ScreenStreamVideoCanvas()
	
	private let videoEngine = ScreenStreamVideoEngine()
	
	private var rtcEngine: AgoraRtcEngineKit {
		get {
			return videoEngine.agoraEngine
		}
	}
	
    var body: some View {
        
		ZStack() {
			ScreenStreamSessionView(
				
				backColor: Color("localBackColor"),
				backImage: Image("big_logo"),
				hideCanvas: !isLocalInSession,
				canvas: localCanvas
				
			).edgesIgnoringSafeArea(.all).onAppear() {print(agora_token)}
			
			VStack {
				HStack {
					
					Spacer()
					
					ScreenStreamSessionView(
						
						backColor: Color("localBackColor"),
						backImage: Image("logo"),
						hideCanvas: isRemoteVideoMuted || !isRemoteInSession || !isLocalInSession,
						canvas: remoteCanvas
						
					).frame(width: 84, height: 112)
					
				}.padding()
				
				Spacer()
				
				HStack {
					
					Button(action: toggleLocalAudio) {
						
						ZStack {
							
							Circle().frame(width: 20, height: 20)
								.padding()
								.foregroundColor(Color.black.opacity(0.25))
								.background(Color.black.opacity(0.25))
								.cornerRadius(70)
							
							if (isLocalAudioMuted) {
								
								FontIcon.text(.ionicon(code: .ios_mic_off), fontsize: 35).foregroundColor(Color.white)
								
							} else {
								
								FontIcon.text(.ionicon(code: .ios_mic), fontsize: 35).foregroundColor(Color.white)
							}
							
						}
						
					}.frame(width: 55, height: 55)
					
					Button(action: toggleLocalSession) {
						
						ZStack {
							
							Circle().frame(width: 20, height: 20)
								.padding()
								.foregroundColor(LightTheme.Colors.error)
								.background(LightTheme.Colors.error)
								.cornerRadius(70)
							
						}
						
					}.frame(width: 70, height: 70)
					
					Button(action: switchCamera) {
						
						ZStack {
							
							Circle().frame(width: 20, height: 20)
								.padding()
								.foregroundColor(Color.black.opacity(0.25))
								.background(Color.black.opacity(0.25))
								.cornerRadius(70)
							
							FontIcon.text(.ionicon(code: .ios_reverse_camera), fontsize: 35).foregroundColor(Color.white)
							
						}
						
					}.frame(width: 55, height: 55)
					
				}.padding()
				
			}
		}.onAppear {
			// This is our usual steps for joining
			// a channel and starting a call.
			self.initializeAgoraEngine()
			
			if (directornot) {
				
				viewModel.startStreamDirectServerCalls(channelId: channelId)
			} else {
				
				viewModel.startStreamClubServerCalls(channelId: channelId, clubId: String(clubId))
			}
			
			self.setupVideo()
			self.setupLocalVideo()
			self.toggleLocalSession()
		}
	}
	
    
}

extension ScreenStreamScreen {
	func log(content: String) {
		print(content)
	}
}

fileprivate extension ScreenStreamScreen {
	func initializeAgoraEngine() {
		// init AgoraRtcEngineKit
		videoEngine.contentView = self
	}
	
	func setupVideo() {
		// In simple use cases, we only need to enable video capturing
		// and rendering once at the initialization step.
		// Note: audio recording and playing is enabled by default.
		rtcEngine.enableVideo()
		
		// Set video configuration
		// Please go to this page for detailed explanation
		// https://docs.agora.io/en/Voice/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:
		rtcEngine.setVideoEncoderConfiguration(
			AgoraVideoEncoderConfiguration(
				size: AgoraVideoDimension640x360,
				frameRate: .fps15,
				bitrate: AgoraVideoBitrateStandard,
				orientationMode: .adaptative
			))
	}
	
	func setupLocalVideo() {
		// This is used to set a local preview.
		// The steps setting local and remote view are very similar.
		// But note that if the local user do not have a uid or do
		// not care what the uid is, he can set his uid as ZERO.
		// Our server will assign one and return the uid via the block
		// callback (joinSuccessBlock) after
		// joining the channel successfully.
		let videoCanvas = AgoraRtcVideoCanvas()
		videoCanvas.view = localCanvas.rendererView
		videoCanvas.renderMode = .hidden
		rtcEngine.setupLocalVideo(videoCanvas)
	}
	
	func joinChannel() {
		// Set audio route to speaker
		rtcEngine.setDefaultAudioRouteToSpeakerphone(true)
		
		// 1. Users can only see each other after they join the
		// same channel successfully using the same app id.
		// 2. One token is only valid for the channel name that
		// you use to generate this token.
		rtcEngine.joinChannel(byToken: agora_token, channelId: channelId, info: nil, uid: UInt(my_id), joinSuccess: nil)
	}
	
	func leaveChannel() {
		// leave channel and end chat
		rtcEngine.leaveChannel(nil)
	}
}

fileprivate extension ScreenStreamScreen {
	func toggleLocalSession() {
		isLocalInSession.toggle()
		if isLocalInSession {
			joinChannel()
		} else {
			leaveChannel()
			
			if (directornot) {
				
				viewModel.stopStreamDirectServerCalls(channelId: channelId)
			} else {
				
				viewModel.stopStreamClubServerCalls(channelId: channelId, clubId: String(clubId))
			}
			
			self.mode.wrappedValue.dismiss()
		}
	}
	
	func switchCamera() {
		rtcEngine.switchCamera()
	}
	
	func toggleLocalAudio() {
		isLocalAudioMuted.toggle()
		// mute/unmute local audio
		rtcEngine.muteLocalAudioStream(isLocalAudioMuted)
	}
}

//struct ScreenStreamScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenStreamScreen()
//    }
//}
