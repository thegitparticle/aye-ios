//
//  MyProfileScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import SwiftUI
import Kingfisher

struct MyProfileScreen: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	@StateObject private var viewModel = MyProfileViewModel()
	
	@State var currentShowingView = "MYPROFILE" // can be MYPROFILE or SETTINGS or EDITPROFILE
	
    var body: some View {
		
		if (self.currentShowingView == "MYPROFILE") {
		
			MyProfile
			
		} else if (self.currentShowingView == "SETTINGS") {
			
			SettingsScreen(changeCurrentShowingView: self.changeCurrentShowingView)
			
		} else if (self.currentShowingView == "EDITPROFILE") {
			
			EditProfileScreen(dpLink: viewModel.userDeetsHere.image, changeCurrentShowingView: self.changeCurrentShowingView)
			
		} else {
			
			MyProfile
		}
		
    }
	
	func changeCurrentShowingView () {
		
		self.currentShowingView = "MYPROFILE"
	}
	
	var MyProfile: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				MyDeets
				
				Spacer()
				
				BottomButtons
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(LightTheme.Colors.uiBackground)
			
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
	}
	
	var MyDeets: some View {
		
		VStack(alignment: .center) {
			
			KFImage.url(URL(string: viewModel.userDeetsHere.image)).resizable().cornerRadius(22.5).frame(width: 55, height: 55).cornerRadius(50.0)
			
			Spacer().frame(height: 20)
			
			VStack {
				
				Text(viewModel.userDeetsHere.user.full_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
				
				Text(viewModel.userDeetsHere.user.username).foregroundColor(LightTheme.Colors.textPrimary.opacity(0.75)).font(LightTheme.Typography.subtitle2).padding(.horizontal, 10).padding(.vertical, 1)
			}
			
			
		}.padding(.vertical, 30).frame(width: UIScreen.screenWidth)
	}
	
	var BottomButtons: some View {
		
		VStack(alignment: .center) {
		
			IconButtonForOptionsWithInfo(title: "clans", info: String(viewModel.userDeetsHere.user.number_of_clubs_joined), iconName: .ios_home, size: 30, color: LightTheme.Colors.special1)
			
			IconButtonForOptionsWithInfo(title: "frames", info: String(viewModel.userDeetsHere.user.total_frames_participation), iconName: .ios_apps, size: 30, color: LightTheme.Colors.special2)
			
			IconButtonForOptions(title: "edit profile", iconName: .ios_brush, size: 30, color: LightTheme.Colors.sucesss).onPress {

				self.currentShowingView = "EDITPROFILE"

			}
			
			IconButtonForOptions(title: "settings", iconName: .ios_settings, size: 30, color: LightTheme.Colors.error).onPress {
				
				self.currentShowingView = "SETTINGS"
				
			}
			
		}.padding(.vertical, 30).frame(width: UIScreen.screenWidth)
	}
	
	var HeaderHere: some View {
	
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Spacer()
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
}

struct MyProfileScreen_Previews: PreviewProvider {
	
    static var previews: some View {
		
        MyProfileScreen()
    }
}
