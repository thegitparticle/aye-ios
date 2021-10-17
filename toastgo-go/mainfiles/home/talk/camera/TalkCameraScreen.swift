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
			
			CameraView(events: events, applicationName: "toastgo-go").frame(maxHeight: .infinity)
			
			VStack {
				
				TopButtons(events: events)
				
				Spacer()
				
				BottomButtons(events: events)
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity)
			
		}.navigationBarHidden(true).background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
	}
}

struct TopButtons: View, CameraActions {
	@ObservedObject var events: UserEvents
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	var body: some View {
		
		HStack {
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				FontIcon.text(.materialIcon(code: .close), fontsize: 35).foregroundColor(Color.white)
				
			}.padding(.horizontal, 10).onTapGesture {
				self.mode.wrappedValue.dismiss()
			}
			
			Spacer ()
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_flash), fontsize: 35).foregroundColor(Color.white)
				
			}.padding(.horizontal, 10)
			
		}.padding(.top, 20)
	}
}

struct CaptureButton: View, CameraActions {
	@ObservedObject var events: UserEvents
	
	var body: some View {
		
		HStack {
			
			ZStack {
				
				Circle().frame(width: 35, height: 35)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
			}.padding(.horizontal, 20).onTapGesture {
				self.takePhoto(events: events)
			}
			
		}
	}
	
}

struct BottomButtons: View, CameraActions {
	@ObservedObject var events: UserEvents
	
	var body: some View {
		
		HStack {
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_images), fontsize: 35).foregroundColor(Color.white)
				
			}.padding(.horizontal, 10).onTapGesture {
				self.changeFlashMode(events: events)
			}
			
			Spacer()
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_reverse_camera), fontsize: 35).foregroundColor(Color.white)
				
			}.padding(.horizontal, 10).onTapGesture {
				self.rotateCamera(events: events)
			}
			
		}.padding(.bottom, 20)
		
	}
}

struct TalkCameraScreen_Previews: PreviewProvider {
	static var previews: some View {
		TalkCameraScreen(clubName: "", clubId: 0, channelId: "", ongoingFrame: false, startTime: "", endTime: "", ongoingStream: false, ongoingStreamUser: "", directornot: false, my_id: 82, my_name: "San")
	}
}
