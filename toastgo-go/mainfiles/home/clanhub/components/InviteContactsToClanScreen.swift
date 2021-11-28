//
//  InviteContactsToClanScreen.swift
//  toastgo-go
//
//  Created by SAN on 11/28/21.
//

import SwiftUI

struct InviteContactsToClanScreen: View {
	
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
	
	@State var showingInvitingOrDonePopup = false
	
	@State var contactsInvitedList: [String] = []
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					LazyVStack(alignment: .leading) {
						
						ForEach(Array(Set(viewModel.contactsList)), id: \.self) {item in
							
							ContactItemComponent(name: item.name, phone: item.phone, addFunction: addContactToList, removeFunction: removeContactFromList).id(UUID())
							
						}
						
						Spacer().frame(height: 250)
					}
					
				}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top).padding(.top, 150)
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
			
			HeaderHere
			
			VStack(alignment: .leading) {
				
				ZStack {
					
					RoundedRectangle(cornerRadius: 30, style: .continuous)
						.fill(LightTheme.Colors.sucesss)
						.frame(width: 200, height: 60)
					
					Text("invite friends to clan").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
					
				}.padding(.vertical, 30).onPress {
					
					self.showingInvitingOrDonePopup = true
					
					for item in contactsInvitedList {
						
						viewModel.inviteFriendToClanApiCall(phonenumber: item, clubid: String(clubId))
					}
					
					self.mode.wrappedValue.dismiss()
				}
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom).popup(isPresented: $showingInvitingOrDonePopup) {
				
				InvitingOrDoneOverlay
				
			}
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	var InvitingOrDoneOverlay: some View {
		
		Text("inviting friends to \(clubName) ...")
			.frame(width: 300, height: 100)
			.background(LightTheme.Colors.uiSurface.opacity(1))
			.foregroundColor(LightTheme.Colors.sucesss)
			.font(LightTheme.Typography.body1)
			.cornerRadius(30.0)
		
	}
	
	func addContactToList(contactPhone: String) {
		
		self.contactsInvitedList.append(contactPhone)
	}
	
	func removeContactFromList(contactPhone: String) {
		
		if let index = self.contactsInvitedList.firstIndex(of: contactPhone) {
			self.contactsInvitedList.remove(at: index)
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

private struct ContactItemComponent: View {
	
	var name: String
	var phone: String
	
	var addFunction: (String) -> ()
	var removeFunction: (String) -> ()
	
	@State private var checkedThisItem = false
	
	var body: some View {
		
		HStack() {
			
			Spacer().frame(width: 20)
			
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

//struct InviteContactsToClanScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        InviteContactsToClanScreen()
//    }
//}
