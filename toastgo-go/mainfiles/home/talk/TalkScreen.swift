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
import HighlightedTextEditor

let betweenUnderscores = try! NSRegularExpression(pattern: "_[^_]+_", options: [])

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
	
	@State private var keyboardIsFocused: Bool = false
	
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
	
	@State var showTextInput: Bool = false
	
	@State var selectedReco: String = ""
	
	@State private var typedText: String = ""
	
	@State private var selectedText = ""
	
	private let rules: [HighlightRule] = [
		HighlightRule(pattern: betweenUnderscores, formattingRules: [
			TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
			TextFormattingRule(key: .foregroundColor, value: UIColor.red),
			TextFormattingRule(key: .underlineStyle) { content, range in
				if content.count > 10 { return NSUnderlineStyle.double.rawValue }
				else { return NSUnderlineStyle.single.rawValue }
			}
		])
	]
	
	@State var showImageViewer: Bool = false
	
	@State var showImageViewerLink: String = "https://..."
	
	@State private var showTalkCameraModal = false
	
	@State private var showStreamLandingModal = false
	
	
	var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack {
				
				if (viewModel.oldMessagesReceived.count > 0) {
					
					ScrollView {
						
						LazyVStack {
							
							Spacer().frame(height: 200)
							
							ForEach(viewModel.oldMessagesReceived, id: \.published) {item in
								
								OldMessageComponent(anOldMessage: item, channelId: channelId, imageViewTriggerFunction: setupImageViewer)
								
							}
							
							ForEach(viewModel.newMessagesReceived, id: \.published) { item in
								
								NewMessageComponent(aNewMessage: item, imageViewTriggerFunction: setupImageViewer)
							}
							
							Spacer().frame(height: 150)
							
						}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom).onTapGesture {
							
							self.closeKeyBoard()
						}
						
					}.frame(width: UIScreen.screenWidth, height: .infinity, alignment: .bottom)
				}
				
			}.frame(width: UIScreen.screenWidth, height: .infinity, alignment: .bottom).onAppear {
				
				self.showButtons = ongoingFrame
				
			}.onTapGesture {
				
				self.closeKeyBoard()
			}
			
			HeaderHere.onAppear() {
				
				if (self.ongoingFrame) {
					
					viewModel.getOldMessagesFromPn(channelId: channelId, start: Int(NSDate().timeIntervalSince1970) * 10000000, end: (Int(startTime) ?? 0) * 10000000, pubnubConfig: pubnubSetUp)
					
				}
				
				viewModel.subscribeToPnChannel(channelId: channelId, pubnubConfig: pubnubSetUp)
			}
			
			if (self.showButtons) {
				
				BottomButtons
				
			} else {
				
				StartFramePart(clubName: clubName, clubId: clubId, channelId: channelId, showButton: {self.showButtons = true}, directornot: directornot, my_id: my_id)
				
			}
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).overlay(ImageViewerRemote(imageURL: self.$showImageViewerLink, viewerShown: self.$showImageViewer)).sheet(isPresented: $showTalkCameraModal) {
			
			TalkCameraScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name, closeTalkCameraModalFunction: closeTalkCameraModal)
		}.sheet(isPresented: $showStreamLandingModal) {
			
			StreamLandingScreen(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name)
		}
		
	}
	
	func setupImageViewer (link: String) {
		
		self.showImageViewerLink = link
		self.showImageViewer = true
	}
	
	func closeTalkCameraModal () {
		
		self.showTalkCameraModal = false
	}
	
	var HeaderHere: some View {
		
		ZStack {
			
			if (self.ongoingStream) {
				
				Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 200, alignment: .top).background(LightTheme.Colors.uiBackground).shadow(color: LightTheme.Colors.textSecondary.opacity(0.05), radius: 40, x: 0, y: 10)
				
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
						
						Text("\( ongoingStreamUser ) is streaming now").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
						
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
	
	var BottomButtons: some View {
		
		VStack {
			
			if (!self.showTextInput) {
				
				HStack {
					
					ZStack {
						
						Circle().frame(width: 20, height: 20)
							.padding()
							.foregroundColor(LightTheme.Colors.textSecondary)
							.background(LightTheme.Colors.textSecondary)
							.cornerRadius(70)
						
						FontIcon.text(.ionicon(code: .ios_camera), fontsize: 25).foregroundColor(LightTheme.Colors.uiSurface)
						
					}.padding(.horizontal, 20).onPress {
						
						self.showTalkCameraModal = true
					}
					
					
					ZStack {
						
						Circle().frame(width: 35, height: 35)
							.padding()
							.foregroundColor(LightTheme.Colors.sucesss)
							.background(LightTheme.Colors.sucesss)
							.cornerRadius(70)
						
						FontIcon.text(.ionicon(code: .ios_add), fontsize: 70).foregroundColor(LightTheme.Colors.uiSurface)
						
					}.padding(.horizontal, 20).onPress {
						
						self.showStreamLandingModal = true
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
							
							KFAnimatedImage.url(URL(string: selectedReco)).cornerRadius(10).frame(width: 100, height: 60).cornerRadius(10.0).padding(.leading, 10)
						}
						
						ScrollView(.horizontal) {
							
							LazyHStack(alignment: .center) {
								
								if (viewModel.customRecos.count > 1 && self.selectedText.count > 2) {
									
									ForEach(viewModel.customRecos , id: \.id) { set in
										
										ForEach(set.links, id: \.self) { link in
											
											KFAnimatedImage.url(URL(string: link)!).cornerRadius(10).frame(width: 100, height: 60).cornerRadius(10.0).onPress {
												self.selectedReco = link
											}
										}
									}
									
								} else {
									
									ForEach(viewModel.defaultRecos , id: \.emoji) { set in
										
										ZStack {
											
											KFAnimatedImage.url(URL(string: set.ayemoji)!).cornerRadius(10).frame(width: 100, height: 60).cornerRadius(10.0).onPress {
												self.selectedReco = set.ayemoji
											}
											
											VStack {
												
												Spacer()
												
												HStack {
													
													Text(set.emoji)
													
													Spacer()
													
												}.frame(width: 100)
												
											}.frame(width: 100, height: 60)
											
										}
										
									}
								}
								
							}.background(LightTheme.Colors.uiSurface).frame(width: .infinity, height: 60)
							
						}
						
					}.background(LightTheme.Colors.uiSurface).frame(width: .infinity, height: 60).onSwipe(down:  {
						
						closeKeyBoard()
					})
					
					HStack(alignment: .center) {
						
						HighlightedTextEditor(text: $typedText, highlightRules: rules)
							// optional modifiers
							.onCommit { print("commited") }
							.onEditingChanged { print("editing changed") }
							// .onTextChange { print("latest text value", $0) }
							.onSelectionChange { (range: NSRange) in
								
								self.selectedText = String(self.typedText.dropFirst(range.lowerBound).prefix(range.upperBound - range.lowerBound) as Substring)
								
								print(self.selectedText)
								
								viewModel.getCustomRecosTalkVM(userid: String(my_id), word: self.selectedText)
								
							}
							.introspect { editor in
								// access underlying UITextView or NSTextView
								editor.textView.backgroundColor = UIColor(LightTheme.Colors.uiSurface)
								editor.textView.font = UIFont(name: "GothamRounded-Book", size: 15)
								editor.textView.textColor = UIColor(LightTheme.Colors.textPrimary)
								
								
							}.frame(width: UIScreen.screenWidth * 0.75, height: 30).padding().font(LightTheme.Typography.body2).background(LightTheme.Colors.uiSurface).cornerRadius(10)
						
						if (self.selectedReco.count > 2) {
							
							FontIcon.text(.ionicon(code: .ios_send), fontsize: 35).foregroundColor(LightTheme.Colors.sucesss).onPress {
								
								viewModel.sendPubnubHMessage(message: self.typedText, selectedReco: self.selectedReco, channelId: channelId, pubnubConfig: pubnubSetUp)
								
							}
							
						} else {
							
							FontIcon.text(.ionicon(code: .ios_send), fontsize: 35).foregroundColor(LightTheme.Colors.textPrimary.opacity(0.25)).onPress {
								
							}
						}
						
					}.frame(width: .infinity)
					
				}.padding(.horizontal, 20).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom).KeyboardAwarePadding().padding(.bottom, 30)
				
			}
			
		}
	}
	
	func closeKeyBoard () {
		
		self.showTextInput = false
		self.selectedText = ""
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
			
			Rectangle().fill(LightTheme.Colors.appLead).frame(maxWidth: .infinity, maxHeight: 300, alignment: .top).background(LightTheme.Colors.appLead).cornerRadius(30)
			
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
										
									}
									
									showButton()
								})
					.frame(width: 320, height: 56)
					.background(Color.yellow)
					.cornerRadius(28)
			}
			
		}.frame( maxHeight: .infinity, alignment: .bottom)
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
