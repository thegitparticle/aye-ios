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

struct TalkScreen: View {
	
	@StateObject private var viewModel = TalkViewModel()
	
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
	
	var defaultRecosPassing: [DefaultRecosDataClass]
	
	var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack {
				
				if (self.showButtons) {
					
					BottomButtons(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name, default_recos: defaultRecosPassing)
					
				} else {
					
					StartFramePart(clubName: clubName, clubId: clubId, channelId: channelId, showButton: {self.showButtons = true}, directornot: directornot, my_id: my_id)
					
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom).onAppear {
				
				self.showButtons = ongoingFrame
				
				viewModel.getDefaultRecos(userid: String(my_id))
			}
			
			HeaderHere(titleText: clubName)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
	
}

private struct BottomButtons: View {
	
	@StateObject private var viewModel = TalkViewModel()
	
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
	
	var default_recos: [DefaultRecosDataClass]
	
	@State var showTextInput: Bool = false
	@ObservedObject var textFieldManagerTalkScreen = TextFieldManagerTalkScreen()
	
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
				
				ZStack {
					
					Circle().frame(width: 35, height: 35)
						.padding()
						.foregroundColor(LightTheme.Colors.sucesss)
						.background(LightTheme.Colors.sucesss)
						.cornerRadius(70)
					
					FontIcon.text(.ionicon(code: .ios_add), fontsize: 70).foregroundColor(LightTheme.Colors.uiSurface)
					
				}.padding(.horizontal, 20)
				
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
				
			}.padding(.vertical, 30)
			
		} else {
			
			VStack {
				
				HStack(alignment: .center) {
					
					Text("Slide to start a frame").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20).onAppear() {
						print("debugrecoshere", viewModel.defaultRecos)
					}
					
					ForEach(viewModel.defaultRecos , id: \.id) { set in
						
						Text("Slide to start a frame").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
						
						ForEach(set.links, id: \.self) { link in
							
							Text("frame lasts for 12 hours").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.caption).padding(20)
							
							KFImage.url(URL(string: link)!).resizable().cornerRadius(5).frame(width: 100, height: 40)
								.cornerRadius(50.0)
						}
					}
					
				}.background(LightTheme.Colors.uiSurface).frame(width: 120, height: 50)
				
				HStack(alignment: .center) {
					
					CocoaTextField("", text: $textFieldManagerTalkScreen.userInput).isFirstResponder(true).keyboardType(.default).frame(width: .infinity, height: 30).padding().foregroundColor(LightTheme.Colors.textSecondary).font(LightTheme.Typography.body2).background(LightTheme.Colors.uiSurface).cornerRadius(10)
					
				}
				
			}.padding(20).frame(maxWidth: .infinity, maxHeight: 100).KeyboardAwarePadding()

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
			
		}.frame(alignment: .center)
	}
}

private struct HeaderHere: View {
	
	var titleText: String
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	var body: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground).shadow(color: LightTheme.Colors.textSecondary.opacity(0.05), radius: 40, x: 0, y: 10)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_arrow_back).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Spacer()
					
					Text(titleText).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
					
					Spacer()
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_apps).padding(.horizontal, 20)
						
					}.onPress {
						
						// add nav to frames view
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
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