//
//  TalkScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/16/21.
//

import SwiftUI
import SwiftUIFontIcon
import SwiftUIX
import AudioToolbox
import Kingfisher
import PubNub
import ImageViewerRemote

extension UIScreen{
	static let screenWidth = UIScreen.main.bounds.size.width
	static let screenHeight = UIScreen.main.bounds.size.height
	static let screenSize = UIScreen.main.bounds.size
}

struct TalkScreen: View {
	
	@StateObject private var viewModel = TalkViewModel()
	@StateObject private var pubnubSetUp = PubnubSetup()
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@State var showButtons: Bool = false
	
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
		
		ZStack(alignment: .top) {
			
			VStack {
				
				if (viewModel.oldMessagesReceived.count > 0) {
					
					ScrollView {
						
						LazyVStack {
							
							Spacer().frame(height: 200)
							
							ForEach(viewModel.oldMessagesReceived, id: \.published) {item in
								
								OldMessageComponent(anOldMessage: item, channelId: channelId)

							}
							
							ForEach(viewModel.newMessagesReceived, id: \.published) { item in
								
								NewMessageComponent(aNewMessage: item)
							}
							
							Spacer().frame(height: 200)
							
						}
					}
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).onAppear {
				
				self.showButtons = ongoingFrame
				
			}
			
			HeaderHere.onAppear() {
				
				if (self.ongoingFrame) {
				
					viewModel.getOldMessagesFromPn(channelId: channelId, start: Int(NSDate().timeIntervalSince1970) * 10000000, end: (Int(startTime) ?? 0) * 10000000, pubnubConfig: pubnubSetUp)
					
				}
				
				viewModel.subscribeToPnChannel(channelId: channelId, pubnubConfig: pubnubSetUp)
			}
			
			if (self.showButtons) {
				
				BottomButtons(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name)
				
			} else {
				
				StartFramePart(clubName: clubName, clubId: clubId, channelId: channelId, showButton: {self.showButtons = true}, directornot: directornot, my_id: my_id)
				
			}
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
	
	var HeaderHere: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground).shadow(color: LightTheme.Colors.textSecondary.opacity(0.05), radius: 40, x: 0, y: 10)
			
			if (self.ongoingStream) {
			
				VStack (alignment: .center) {
					
					Spacer(minLength: statusBarHeight)
					
					HStack () {
						
						HStack {
							
							CircleIcon(size: 13, iconName: .ios_arrow_back).padding(.horizontal, 20)
							
						}.onPress {
							
							self.mode.wrappedValue.dismiss()
						}
						
						Spacer()
						
						Text(clubName).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
						
						Spacer()
						
						NavigationLink(destination: FramesListScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name)) {
							
							HStack {
								
								CircleIcon(size: 13, iconName: .ios_apps).padding(.horizontal, 20)
								
							}
							
						}
						
					}.padding(.bottom, 5)
					
					HStack () {
						
						Text("\( viewModel.otherUserDetailsHere[0].user.full_name ) is streaming now").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
						
						Spacer()
						
						NavigationLink(destination: ViewLiveStreamScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name, agora_token: viewModel.agoraToken)) {
							
							ZStack {
								
								RoundedRectangle(cornerRadius: 15, style: .continuous).frame(width: 75, height: 30)
									.padding()
									.foregroundColor(LightTheme.Colors.sucesss.opacity(0.25))
								
								Text("join").foregroundColor(LightTheme.Colors.sucesss).font(LightTheme.Typography.subtitle2)
								
							}.onAppear() {
								
								viewModel.getOtherUserDetails(otheruserid: self.ongoingStreamUser)
								viewModel.getAgoraToken(channelId: self.channelId)
							}
						}
						
					}.padding(.bottom, 5)
					
				}.frame(maxWidth: .infinity, maxHeight: 200, alignment: .top)
				
			} else {
				
				VStack (alignment: .center) {
					
					Spacer(minLength: statusBarHeight)
					
					HStack () {
						
						HStack {
							
							CircleIcon(size: 13, iconName: .ios_arrow_back).padding(.horizontal, 20)
							
						}.onPress {
							
							self.mode.wrappedValue.dismiss()
						}
						
						Spacer()
						
						Text(clubName).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
						
						Spacer()
						
						NavigationLink(destination: FramesListScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name)) {
							
							HStack {
								
								CircleIcon(size: 13, iconName: .ios_apps).padding(.horizontal, 20)
								
							}
							
						}
						
					}.padding(.bottom, 5)
					
				}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
			}
		}
		
	}
	
}

private struct BottomButtons: View {
	
	@StateObject private var viewModel = TalkViewModel()
	@StateObject private var pubnubSetUp = PubnubSetup()
	
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
	
	//	var default_recos: [DefaultRecosDataClass]
	
	@State var showTextInput: Bool = false
	@ObservedObject var textFieldManagerTalkScreen = TextFieldManagerTalkScreen()
	
	@State var selectedReco: String = ""
	
	var body: some View {
		
		if (!showTextInput) {
			
			HStack {
				
				NavigationLink(destination: TalkCameraScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name)) {
					
					ZStack {
						
						Circle().frame(width: 20, height: 20)
							.padding()
							.foregroundColor(LightTheme.Colors.textSecondary)
							.background(LightTheme.Colors.textSecondary)
							.cornerRadius(70)
						
						FontIcon.text(.ionicon(code: .ios_camera), fontsize: 25).foregroundColor(LightTheme.Colors.uiSurface)
						
					}.padding(.horizontal, 20)
					
				}
				
				NavigationLink(destination: StreamLandingScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name)) {
				
				ZStack {
					
					Circle().frame(width: 35, height: 35)
						.padding()
						.foregroundColor(LightTheme.Colors.sucesss)
						.background(LightTheme.Colors.sucesss)
						.cornerRadius(70)
					
					FontIcon.text(.ionicon(code: .ios_add), fontsize: 70).foregroundColor(LightTheme.Colors.uiSurface)
					
				}.padding(.horizontal, 20)
					
				}
				
				ZStack {
					
					Circle().frame(width: 20, height: 20)
						.padding()
						.foregroundColor(LightTheme.Colors.appLead)
						.background(LightTheme.Colors.appLead)
						.cornerRadius(70)
					
					FontIcon.text(.materialIcon(code: .keyboard), fontsize: 25).foregroundColor(LightTheme.Colors.uiSurface)
					
				}.padding(.horizontal, 20).onPress {
					
					self.showTextInput = true
				}
				
			}.padding(.vertical, 30).frame(maxHeight: .infinity, alignment: .bottom)
			
		} else {
			
			VStack {
				
				HStack {
					
					if (self.selectedReco.count > 2) {
						
						KFAnimatedImage.url(URL(string: selectedReco)).cornerRadius(10).frame(width: 100, height: 60).cornerRadius(10.0)
					}
					
					ScrollView(.horizontal) {
						
						LazyHStack(alignment: .center) {
							
							ForEach(viewModel.defaultRecos , id: \.id) { set in
								
								ForEach(set.links, id: \.self) { link in
									
									KFAnimatedImage.url(URL(string: link)!).cornerRadius(10).frame(width: 100, height: 60).cornerRadius(10.0).onPress {
										self.selectedReco = link
									}
								}
							}
							
						}.background(LightTheme.Colors.uiSurface).frame(width: .infinity, height: 60)
						
					}
					
				}.background(LightTheme.Colors.uiSurface).frame(width: .infinity, height: 60)
				
				HStack(alignment: .center) {
					
					CocoaTextField("", text: $textFieldManagerTalkScreen.userInput).isFirstResponder(true).keyboardType(.default).frame(width: .infinity, height: 30).padding().foregroundColor(LightTheme.Colors.textSecondary).font(LightTheme.Typography.body2).background(LightTheme.Colors.uiSurface).cornerRadius(10)
					
					if (self.selectedReco.count > 2) {
						
						FontIcon.text(.ionicon(code: .ios_send), fontsize: 35).foregroundColor(LightTheme.Colors.sucesss).onPress {
							
							viewModel.sendPubnubHMessage(message: textFieldManagerTalkScreen.userInput, selectedReco: self.selectedReco, channelId: channelId, pubnubConfig: pubnubSetUp)
							
						}
					}
					
				}
				
			}.padding(.horizontal, 20).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom).KeyboardAwarePadding().padding(.bottom, 30)
			
		}
	}
}

private struct StartFramePart: View {
	
	var clubName: String
	var clubId: Int
	var channelId: String
	var showButton: () -> ()
	var directornot: Bool
	var my_id: Int
	
	@StateObject private var viewModel = TalkViewModel()
	
	var body: some View{
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.appLeadVariant).frame(maxWidth: .infinity, maxHeight: 300, alignment: .top).background(LightTheme.Colors.appLeadVariant).cornerRadius(30)
			
			VStack {
				
				Text("Slide to start a frame").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
				
				Text("frame lasts for 12 hours").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.caption).padding(20)
				
				SliderComponent(thumbnailColor: Color.red,
								
								didReachEndAction: { view in
									
									DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
										if (directornot) {
											
											viewModel.postStartDirectFrame(other_user_id: clubId, channel_id: channelId, my_id: my_id)
										} else {
											
											viewModel.postStartClanFrame(club_name: clubId, channel_id: channelId)
										}
										showButton()
									}
								})
					.frame(width: 320, height: 56)
					.background(Color.yellow)
					.cornerRadius(28)
			}
			
		}.frame( maxHeight: .infinity, alignment: .center)
	}
}

class TextFieldManagerTalkScreen: ObservableObject {
	
	let characterLimit = 140
	
	@Published var userInput = "" {
		didSet {
			if userInput.count > characterLimit {
				userInput = String(userInput.prefix(characterLimit))
				AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
			}
		}
	}
	
}

//struct TalkScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		TalkScreen(clubName: "", clubId: 0, channelId: "", ongoingFrame: false, startTime: "", endTime: "", ongoingStream: false, ongoingStreamUser: "", directornot: false, my_id: 82, my_name: "San")
//	}
//}
