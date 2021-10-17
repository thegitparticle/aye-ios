//
//  TalkCameraScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/17/21.
//

import SwiftUI
import SwiftUICam
import SwiftUIFontIcon

struct TalkCameraScreen: View {
	
	@ObservedObject var events = UserEvents()
	
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
	
	var body: some View {
		
		ZStack {
			
			CameraView(events: events, applicationName: "toastgo-go")
			
			VStack {
				CameraInterfaceView(events: events)
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
			
		}.navigationBarHidden(true).background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
	}
}

struct CameraInterfaceView: View, CameraActions {
	@ObservedObject var events: UserEvents
	
	var body: some View {
		
		HStack {
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.white)
					.background(Color.white)
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_images), fontsize: 25).foregroundColor(Color.black)
				
			}.padding(.horizontal, 20)
			
			ZStack {
				
				Circle().frame(width: 35, height: 35)
					.padding()
					.foregroundColor(Color.white)
					.background(Color.white)
					.cornerRadius(70)
				
			}.padding(.horizontal, 20).onTapGesture {
				self.takePhoto(events: events)
			}
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.white)
					.background(Color.white)
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_reverse_camera), fontsize: 25).foregroundColor(Color.black)
				
			}.padding(.horizontal, 20).onTapGesture {
				self.rotateCamera(events: events)
			}
			
		}.padding(.vertical, 30)
		
		//		VStack {
		//			HStack {
		////				rotateButton().onTapGesture {
		////					self.rotateCamera(events: events)
		////				}
		//				Spacer()
		////				flashButton().onTapGesture {
		////					self.changeFlashMode(events: events)
		////				}
		//			}
		//			Spacer()
		////			captureButton().onTapGesture {
		////				self.takePhoto(events: events)
		////			}
		//		}
	}
}

struct TalkCameraScreen_Previews: PreviewProvider {
	static var previews: some View {
		TalkCameraScreen(clubName: "", clubId: 0, channelId: "", ongoingFrame: false, startTime: "", endTime: "", ongoingStream: false, ongoingStreamUser: "", directornot: false, my_id: 82, my_name: "San")
	}
}
