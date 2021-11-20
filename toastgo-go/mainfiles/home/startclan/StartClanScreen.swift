//
//  StartClanScreen.swift
//  toastgo-go
//
//  Created by SAN on 11/20/21.
//

import SwiftUI
import SwiftUIFontIcon

struct StartClanScreen: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	@StateObject private var viewModel = StartClanViewModel()
	
	@State var currentShowingView = "FRIENDSLIST" // can be FRIENDSLIST, CONTACTSLIST, NAMECLAN or CREATINGCLAN
	
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
						
						ForEach(Array(Set(viewModel.contactsList)), id: \.self) {item in
							
							ContactItemComponentHere(name: item.name, phone: item.phone).id(UUID())
							
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
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
	
	var ContactsListView: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					LazyVStack(alignment: .leading) {
						
						ForEach(Array(Set(viewModel.contactsList)), id: \.self) {item in
							
							ContactItemComponentHere(name: item.name, phone: item.phone).id(UUID())
							
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
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Spacer()
					
					Text("Invite Contacts").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.h5).padding(.horizontal, 10).padding(.vertical, 3)
					
					Spacer()
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
	
	var NameClanView: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					LazyVStack(alignment: .leading) {
						
						ForEach(Array(Set(viewModel.contactsList)), id: \.self) {item in
							
							ContactItemComponentHere(name: item.name, phone: item.phone).id(UUID())
							
						}
						
						
					}
					
				}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top).padding(.top, 150)
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
			
			NameClanViewHeader
			
			VStack(alignment: .leading) {
				
				ZStack {
					
					Circle().frame(width: CGFloat(20), height: 20)
						.padding()
						.foregroundColor(LightTheme.Colors.textSecondary)
						.background(LightTheme.Colors.textSecondary)
						.cornerRadius(70)
					
					FontIcon.text(.ionicon(code: .ios_arrow_round_forward), fontsize: CGFloat(20)).foregroundColor(LightTheme.Colors.uiSurface.opacity(0.75))
					
				}.padding(.vertical, 30).onPress {
					
					self.currentShowingView = "CREATINGCLAN"
				}
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
	}
	
	var NameClanViewHeader: some View {
		
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
					
					Text("Clan Name").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.h5).padding(.horizontal, 10).padding(.vertical, 3)
					
					Spacer()
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
	
	var CreatingClanView: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					LazyVStack(alignment: .leading) {
						
						ForEach(Array(Set(viewModel.contactsList)), id: \.self) {item in
							
							ContactItemComponentHere(name: item.name, phone: item.phone).id(UUID())
							
						}
						
						
					}
					
				}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top).padding(.top, 150)
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
			
			CreatingClanViewHeader
			
			VStack(alignment: .leading) {
				
				ZStack {
					
					Circle().frame(width: CGFloat(20), height: 20)
						.padding()
						.foregroundColor(LightTheme.Colors.textSecondary)
						.background(LightTheme.Colors.textSecondary)
						.cornerRadius(70)
					
					FontIcon.text(.ionicon(code: .ios_arrow_round_forward), fontsize: CGFloat(20)).foregroundColor(LightTheme.Colors.uiSurface.opacity(0.75))
					
				}.padding(.vertical, 30).onPress {
					
					self.mode.wrappedValue.dismiss()
				}
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .bottom)
			
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
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Spacer()
					
					Text("").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.h5).padding(.horizontal, 10).padding(.vertical, 3)
					
					Spacer()
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
	
}

private struct ContactItemComponentHere: View {
	
	var name: String
	var phone: String
	
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
			
			
		}.frame(width: UIScreen.screenWidth).padding(.vertical, 10)
		
	}
}

struct StartClanScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartClanScreen()
    }
}
