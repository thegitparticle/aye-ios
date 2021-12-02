//
//  StartClanScreen.swift
//  toastgo-go
//
//  Created by SAN on 11/20/21.
//

import SwiftUI
import SwiftUIFontIcon
import Kingfisher
import SwiftUIX
import AudioToolbox

struct StartClanScreen: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	@StateObject private var viewModel = StartClanViewModel()
	
	@State var currentShowingView = "FRIENDSLIST" // can be FRIENDSLIST, CONTACTSLIST, NAMECLAN or CREATINGCLAN
	
	@ObservedObject var textFieldManagerHere = TextFieldManagerStartClan()
	
	@State var friendsAddedList: [Int] = []
	@State var contactsInvitedList: [String] = []
	
	var body: some View {
		
		if (currentShowingView == "FRIENDSLIST") {
			
			FriendsListView
			
		} else if (currentShowingView == "CONTACTSLIST") {
			
			ContactsListView
			
		} else if (currentShowingView == "NAMECLAN") {
			
			NameClanView
			
		} else if (currentShowingView == "CREATINGCLAN") {
			
			CreatingClanView
			
		} else {
			
			FriendsListView
		}
		
	}
	
	var FriendsListView: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					LazyVStack(alignment: .leading) {
						
						if (viewModel.friendsList.count == 0) {
							
							VStack(alignment: .center) {
								
								CubeOffset()
								
							}.frame(width: UIScreen.screenWidth).padding(.top, (UIScreen.screenHeight * 0.5) - 150)
							
						} else {
							
							ForEach(Array(Set(viewModel.friendsList)), id: \.self) {item in
								
								FriendItemComponentHere(name: item.name, id: item.friend_user_id, dp: item.profile_pic, addFunction: addFriendToList, removeFunction: removeFriendFromList)
								
							}
							
							Spacer().frame(height: 250)
						}
						
					}
					
				}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top).padding(.top, 150)
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
			
			FriendsListViewHeader
			
			VStack(alignment: .leading) {
				
				ZStack {
					
					Circle().frame(width: CGFloat(20), height: 20)
						.padding()
						.foregroundColor(LightTheme.Colors.textSecondary)
						.background(LightTheme.Colors.textSecondary)
						.cornerRadius(70)
					
					FontIcon.text(.ionicon(code: .ios_arrow_round_forward), fontsize: CGFloat(20)).foregroundColor(LightTheme.Colors.uiSurface.opacity(0.75))
					
				}.padding(.vertical, 30).onPress {
					
					self.currentShowingView = "CONTACTSLIST"
				}
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
	}
	
	var FriendsListViewHeader: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				Spacer().frame(height: 25)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Spacer()
					
					Text("Choose Friends").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.h5).padding(.horizontal, 10).padding(.vertical, 3)
					
					Spacer()
					
					ZStack() {
						
						Circle().frame(width: CGFloat(13), height: CGFloat(13))
							.padding()
							.foregroundColor(LightTheme.Colors.uiBackground)
							.background(LightTheme.Colors.uiBackground)
							.cornerRadius(70)
						
					}.padding(.horizontal, 20)
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
	
	var ContactsListView: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					LazyVStack(alignment: .leading) {
						
						if (viewModel.contactsList.count == 0) {
							
							VStack(alignment: .center) {
								
								CubeOffset()
								
							}.frame(width: UIScreen.screenWidth).padding(.top, (UIScreen.screenHeight * 0.5) - 150)
							
						} else {
							
							ForEach(Array(Set(viewModel.contactsList)), id: \.self) {item in
								
								ContactItemComponentHere(name: item.name, phone: item.phone, addFunction: addContactToList, removeFunction: removeContactFromList)
								
							}
							
							Spacer().frame(height: 250)
						}
						
					}
					
				}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top).padding(.top, 150)
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
			
			ContactsListViewHeader
			
			VStack(alignment: .leading) {
				
				ZStack {
					
					Circle().frame(width: CGFloat(20), height: 20)
						.padding()
						.foregroundColor(LightTheme.Colors.textSecondary)
						.background(LightTheme.Colors.textSecondary)
						.cornerRadius(70)
					
					FontIcon.text(.ionicon(code: .ios_arrow_round_forward), fontsize: CGFloat(20)).foregroundColor(LightTheme.Colors.uiSurface.opacity(0.75))
					
				}.padding(.vertical, 30).onPress {
					
					self.currentShowingView = "NAMECLAN"
				}
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
	}
	
	var ContactsListViewHeader: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				Spacer().frame(height: 25)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_arrow_back).padding(.horizontal, 20)
						
					}.onPress {
						
						self.currentShowingView = "FRIENDSLIST"
					}
					
					Spacer()
					
					Text("Invite Contacts").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.h5).padding(.horizontal, 10).padding(.vertical, 3)
					
					Spacer()
					
					ZStack() {
						
						Circle().frame(width: CGFloat(13), height: CGFloat(13))
							.padding()
							.foregroundColor(LightTheme.Colors.uiBackground)
							.background(LightTheme.Colors.uiBackground)
							.cornerRadius(70)
						
					}.padding(.horizontal, 20)
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
	
	var NameClanView: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				HStack(alignment: .center) {
					
					CocoaTextField("", text: $textFieldManagerHere.userInput).isFirstResponder(true).keyboardType(.default).frame(width: 200, height: 40).padding().foregroundColor(LightTheme.Colors.textSecondary).font(LightTheme.Typography.body2).background(LightTheme.Colors.uiSurface).cornerRadius(10)
					
				}.padding(20).frame(maxWidth: .infinity)
				
				ZStack {
					
					Circle().frame(width: CGFloat(20), height: 20)
						.padding()
						.foregroundColor(LightTheme.Colors.textSecondary)
						.background(LightTheme.Colors.textSecondary)
						.cornerRadius(70)
					
					FontIcon.text(.ionicon(code: .ios_arrow_round_forward), fontsize: CGFloat(20)).foregroundColor(LightTheme.Colors.uiSurface.opacity(0.75))
					
				}.padding(.vertical, 30).onPress {
					
					self.currentShowingView = "CREATINGCLAN"
					
					viewModel.postStartNewClan(clan_name: self.textFieldManagerHere.userInput, friendsList: self.friendsAddedList, contactsList: self.contactsInvitedList)
				}
				
			}.frame(maxWidth: UIScreen.screenWidth, maxHeight: UIScreen.screenHeight, alignment: .top).padding(.top, 200)
			
			NameClanViewHeader
			
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).onAppear() {
			
			print(friendsAddedList)
			print(contactsInvitedList)
		}
		
	}
	
	var NameClanViewHeader: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				Spacer().frame(height: 25)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_arrow_back).padding(.horizontal, 20)
						
					}.onPress {
						
						self.currentShowingView = "CONTACTSLIST"
					}
					
					Spacer()
					
					Text("Clan Name").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.h5).padding(.horizontal, 10).padding(.vertical, 3)
					
					Spacer()
					
					ZStack() {
						
						Circle().frame(width: CGFloat(13), height: CGFloat(13))
							.padding()
							.foregroundColor(LightTheme.Colors.uiBackground)
							.background(LightTheme.Colors.uiBackground)
							.cornerRadius(70)
						
					}.padding(.horizontal, 20)
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
	
	var CreatingClanView: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				if (!viewModel.clanSetUpStatus)
				{
					
					HStack(alignment: .center) {
						
						LottieView(filename: "loading_ping_pong_cup")
						
					}.padding(20).frame(maxWidth: .infinity, maxHeight: 200)
					
					Text("building your clan").foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.h4).padding(20)
					
				} else {
					
					Text("clan created!").foregroundColor(LightTheme.Colors.sucesss).font(LightTheme.Typography.h4).padding(20).onAppear() {
						
						self.mode.wrappedValue.dismiss()
					}
				}
				
			}.frame(maxWidth: UIScreen.screenWidth, maxHeight: UIScreen.screenHeight, alignment: .top).padding(.top, 200)
			
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
	}
	
	var CreatingClanViewHeader: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				Spacer().frame(height: 25)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_arrow_back).padding(.horizontal, 20)
						
					}.onPress {
						
						self.currentShowingView = "CONTACTSLIST"
					}
					
					Spacer()
					
					Text("Clan Name").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.h5).padding(.horizontal, 10).padding(.vertical, 3)
					
					Spacer()
					
					ZStack() {
						
						Circle().frame(width: CGFloat(13), height: CGFloat(13))
							.padding()
							.foregroundColor(LightTheme.Colors.uiBackground)
							.background(LightTheme.Colors.uiBackground)
							.cornerRadius(70)
						
					}.padding(.horizontal, 20)
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
	
	func addFriendToList(friendId: Int) {
		
		self.friendsAddedList.append(friendId)
	}
	
	func removeFriendFromList(friendId: Int) {
		
		if let index = self.friendsAddedList.firstIndex(of: friendId) {
			self.friendsAddedList.remove(at: index)
		}
	}
	
	func addContactToList(contactPhone: String) {
		
		self.contactsInvitedList.append(contactPhone)
	}
	
	func removeContactFromList(contactPhone: String) {
		
		if let index = self.contactsInvitedList.firstIndex(of: contactPhone) {
			self.contactsInvitedList.remove(at: index)
		}
		
	}
	
}

private struct FriendItemComponentHere: View {
	
	var name: String
	var id: Int
	var dp: String
	
	var addFunction: (Int) -> ()
	var removeFunction: (Int) -> ()
	
	@State private var checkedThisItem = false
	
	var body: some View {
		
		HStack() {
			
			Spacer().frame(width: 25)
			
			Toggle("", isOn: self.$checkedThisItem)
				.toggleStyle(CheckboxToggleStyle(style: .square))
				.foregroundColor(.blue)
			
			Spacer().frame(width: 10)
			
			KFImage.url(URL(string: dp)!).resizable().cornerRadius(20).frame(width: 40, height: 40)
				.cornerRadius(50.0)
			
			Spacer().frame(width: 10)
			
			Text(self.name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 3)
			
			Spacer()
			
			
		}.frame(width: UIScreen.screenWidth).padding(.vertical, 5).onPress {
			
			if (!self.checkedThisItem) {
				
				addFunction(id)
				self.checkedThisItem = true
			} else {
				
				removeFunction(id)
				self.checkedThisItem = false
			}
			
		}
		
	}
}

private struct ContactItemComponentHere: View {
	
	var name: String
	var phone: String
	
	var addFunction: (String) -> ()
	var removeFunction: (String) -> ()
	
	@State private var checkedThisItem = false
	
	var body: some View {
		
		HStack() {
			
			Spacer().frame(width: 25)
			
			Toggle("", isOn: self.$checkedThisItem)
				.toggleStyle(CheckboxToggleStyle(style: .square))
				.foregroundColor(.blue)
			
			Spacer().frame(width: 20)
			
			Text(self.name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 3)
			
			Spacer()
			
			
		}.frame(width: UIScreen.screenWidth).padding(.vertical, 10).onPress {
			
			if (!self.checkedThisItem) {
				
				addFunction(phone)
				self.checkedThisItem = true
			} else {
				
				removeFunction(phone)
				self.checkedThisItem = false
			}
		}
		
	}
}

class TextFieldManagerStartClan: ObservableObject {
	
	let characterLimit = 16
	
	@Published var userInput = "" {
		didSet {
			if userInput.count > characterLimit {
				userInput = String(userInput.prefix(characterLimit))
				AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
			}
		}
	}
	
}

struct StartClanScreen_Previews: PreviewProvider {
	static var previews: some View {
		StartClanScreen()
	}
}
