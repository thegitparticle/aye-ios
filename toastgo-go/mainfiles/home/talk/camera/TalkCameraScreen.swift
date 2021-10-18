//
//  TalkCameraScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/17/21.
//

import SwiftUI
import SwiftUICam
import SwiftUIFontIcon
import Camera_SwiftUI

struct TalkCameraScreen: View {
	
	@ObservedObject var events = UserEvents()
	
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
	
	@StateObject var model = TalkCameraViewModel()
	
	@State var currentZoomFactor: CGFloat = 1.0
	
	var body: some View {
		
		GeometryReader { reader in
			
			ZStack {
				
				VStack {
					
					topButtons
					
					CameraPreview(session: model.session)
						.gesture(
							DragGesture().onChanged({ (val) in
								//  Only accept vertical drag
								if abs(val.translation.height) > abs(val.translation.width) {
									//  Get the percentage of vertical screen space covered by drag
									let percentage: CGFloat = -(val.translation.height / reader.size.height)
									//  Calculate new zoom factor
									let calc = currentZoomFactor + percentage
									//  Limit zoom factor to a maximum of 5x and a minimum of 1x
									let zoomFactor: CGFloat = min(max(calc, 1), 5)
									//  Store the newly calculated zoom factor
									currentZoomFactor = zoomFactor
									//  Sets the zoom factor to the capture device session
									model.zoom(with: zoomFactor)
								}
							})
						).onAppear {
							model.configure()
						}
						.animation(.easeInOut)
					
					captureButton
					
					bottomButtons
					
				}
				
				
			}.navigationBarHidden(true).background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
			
		}
		
	}
	
	var captureButton: some View {
		
		HStack {
			
			ZStack {
				Button(action: {
					model.capturePhoto()
				}, label: {
					Circle()
						.foregroundColor(.white)
						.frame(width: 80, height: 80, alignment: .center)
						.overlay(
							Circle()
								.stroke(Color.black.opacity(0.8), lineWidth: 2)
								.frame(width: 65, height: 65, alignment: .center)
						)
				})
				
			}.padding(.vertical, 30)
		}
	}
	
	var topButtons: some View {
		
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
				
				if (model.isFlashOn) {
					
					FontIcon.text(.ionicon(code: .ios_flash), fontsize: 35).foregroundColor(Color.white)
					
				} else {
					
					FontIcon.text(.ionicon(code: .ios_flash_off), fontsize: 35).foregroundColor(Color.white)
				}
				
			}.padding(.horizontal, 10).onTapGesture {
				model.switchFlash()
			}
			
		}.padding(.top, 20)
	}
	
	
	var bottomButtons: some View {
		
		HStack {
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_images), fontsize: 35).foregroundColor(Color.white)
				
			}.padding(.horizontal, 10).onTapGesture {
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
				model.flipCamera()
			}
			
		}.padding(.bottom, 20)
	}
	
}

struct TalkCameraScreen_Previews: PreviewProvider {
	static var previews: some View {
		TalkCameraScreen(clubName: "", clubId: 0, channelId: "", ongoingFrame: false, startTime: "", endTime: "", ongoingStream: false, ongoingStreamUser: "", directornot: false, my_id: 82, my_name: "San")
	}
}
