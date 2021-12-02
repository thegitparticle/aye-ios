//
//  AddFriendsToClanScreen.swift
//  toastgo-go
//
//  Created by SAN on 11/28/21.
//

import SwiftUI
import Kingfisher

struct AddFriendsToClanScreen: View {
	
	var clubName: String     // in directs, its the other user's name
	var clubId: Int 			// in directs, its the other user's id
	var channelId: String
	var ongoingFrame: Bool
	var startTime: String
	var endTime: String
	var ongoingStream: Bool
	var ongoingStreamUser: String
	var directornot: Bool
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@StateObject private var viewModel = ClanHubViewModel()
	
	@State var showingAddingOrDonePopup = false
	
	@State var friendsAddedList: [Int] = []

    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					LazyVStack(alignment: .leading) {
						
						
						if (viewModel.friendsList.count == 0) {
							
							VStack(alignment: .center) {
								
								CubeOffset()
								
							}.frame(width: UIScreen.screenWidth).padding(.top, (UIScreen.screenHeight * 0.5) - 150)
							
						} else {
							
							
							ForEach(Array(Set(viewModel.friendsList)), id: \.friend_user_id) {item in
								
								FriendItemComponent(name: item.name, userid: item.friend_user_id, profilepic: item.profile_pic, addFunction: addFriendToList, removeFunction: removeFriendFromList)
								
							}
							
							Spacer().frame(height: 250)
						}
						
					}
					
				}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top).padding(.top, 150)
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
			
			
			HeaderHere
			
			VStack(alignment: .leading) {
				
				ZStack {
					
					RoundedRectangle(cornerRadius: 30, style: .continuous)
						.fill(LightTheme.Colors.sucesss)
						.frame(width: 180, height: 60)
					
					Text("add friends").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
					
				}.padding(.vertical, 30).onPress {
					
					self.showingAddingOrDonePopup = true
					
					for item in friendsAddedList {
						
						viewModel.addFriendToClanApiCall(adduserid: String(item), clubid: String(clubId))
					}
					
					self.mode.wrappedValue.dismiss()
				}
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom).popup(isPresented: $showingAddingOrDonePopup) {
				
				AddingOrDoneOverlay
				
			}
			
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	var AddingOrDoneOverlay: some View {
		
		Text("adding friends ...")
			.frame(width: 300, height: 100)
			.background(LightTheme.Colors.uiSurface.opacity(1))
			.foregroundColor(LightTheme.Colors.sucesss)
			.font(LightTheme.Typography.body1)
			.cornerRadius(30.0)
		
	}
	
	func addFriendToList(friendId: Int) {
		
		self.friendsAddedList.append(friendId)
	}
	
	func removeFriendFromList(friendId: Int) {
		
		if let index = self.friendsAddedList.firstIndex(of: friendId) {
			self.friendsAddedList.remove(at: index)
		}
	}
	
	var HeaderHere: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(width: UIScreen.screenWidth, height: 150, alignment: .top).background(LightTheme.Colors.uiBackground)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}.padding(.bottom, 25)
					
					Spacer()
					
				}
				
			}.frame(width: UIScreen.screenWidth, height: 150, alignment: .top)
		}
		
	}
}

struct FriendItemComponent: View {
	
	var name: String
	var userid: Int
	var profilepic: String
	
	var addFunction: (Int) -> ()
	var removeFunction: (Int) -> ()
	
	@State private var checkedThisItem = false
	
	var body: some View {
		
		HStack() {
			
			Spacer().frame(width: 20)
			
			Toggle("", isOn: self.$checkedThisItem)
				.toggleStyle(CheckboxToggleStyle(style: .square))
				.foregroundColor(.blue)
			
			Spacer().frame(width: 20)
			
			KFImage.url(URL(string: self.profilepic)!).resizable().cornerRadius(20).frame(width: 40, height: 40)
				.cornerRadius(50.0)
			
			Spacer().frame(width: 10)
			
			Text(self.name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 3)
			
			Spacer()
			
			
		}.frame(width: UIScreen.screenWidth).padding(.vertical, 10).onPress {
			
			if (!self.checkedThisItem) {
				
				addFunction(userid)
				self.checkedThisItem = true
				
			} else {
				
				removeFunction(userid)
				self.checkedThisItem = false
			}
			
		}
		
	}
}

//struct AddFriendsToClanScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddFriendsToClanScreen()
//    }
//}
