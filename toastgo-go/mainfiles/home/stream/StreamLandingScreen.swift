//
//  StreamLandingScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/20/21.
//

import SwiftUI
import Camera_SwiftUI
import SwiftUIFontIcon


struct StreamLandingScreen: View {
	
	@StateObject private var viewModel = StreamLandingViewModel()
	
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
	
	var body: some View {
		
		GeometryReader { proxy in
			
			ZStack {
				
				VStack() {
					
//					NavigationLink(destination: CamStreamScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name, agora_token: viewModel.agoraToken)) {
						
						HStack () {
							
							ZStack {
								
								CameraPreview(session: viewModel.session).frame(width: proxy.size.width, height: (proxy.size.height / 2))
									.onAppear {
										viewModel.configure()
									}
									.animation(.easeInOut)
								
								
								Text("stream from camera").foregroundColor(Color.gray).font(LightTheme.Typography.subtitle1)
								
							}
							
						}.frame(width: proxy.size.width, height: (proxy.size.height / 2) ).background(LightTheme.Colors.sucesss)
						
//					}
					
//										NavigationLink(destination: ScreenStreamScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name, agora_token: viewModel.agoraToken)) {
					
					NavigationLink(destination: ScreenShare100UI()) {
					
					HStack () {
						
						Text("stream your fav app").foregroundColor(Color.gray).font(LightTheme.Typography.subtitle1)
						
					}.frame(width: proxy.size.width, height: (proxy.size.height / 2) ).background(Color.black)
					
										}
					
				}.navigationBarHidden(true).background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).onAppear() {
					
					viewModel.getAgoraToken(channelId: channelId)
				}
				
				
				topButtons
			}
			
		}.navigationBarHidden(true).background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).onDisappear() {
			
			viewModel.destroyCamera()
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
				
				viewModel.destroyCamera()
				self.mode.wrappedValue.dismiss()
			}
			
			Spacer ()
			
		}.padding(.top, 20).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
	}
}

//struct StreamLandingScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        StreamLandingScreen()
//    }
//}
