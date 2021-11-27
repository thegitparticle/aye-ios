//
//  ClanHubScreen.swift
//  toastgo-go
//
//  Created by SAN on 11/27/21.
//

import SwiftUI
import Kingfisher

struct ClanHubScreen: View {
	
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
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@StateObject private var viewModel = ClanHubViewModel()
	
	@State private var showAddFriendsModal = false
	@State private var showInviteFriendsModal = false
	@State private var showingQuitClanPopup = false
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				ScrollView {
					
					Spacer().frame(height: 30)
				
					FramesCount
					
					Spacer().frame(height: 30)
					
					ListOfMembers
					
					Spacer().frame(height: 30)
					
					AddPeopleToClanButtons
					
					Spacer().frame(height: 30)
					
					QuitButton
					
				}.frame(width: UIScreen.screenWidth)
				
			}.frame(maxWidth: UIScreen.screenWidth, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(LightTheme.Colors.uiBackground).popup(isPresented: $showingQuitClanPopup) {

				QuitClanOverlay

			}
			
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).onAppear() {
			
			viewModel.getClanDetails(clubId: String(clubId))
		}
		
    }
	
	var QuitClanOverlay: some View {
		
		Text("you really wanna quit this clan?")
			.frame(width: 300, height: 100)
			.background(LightTheme.Colors.uiSurface.opacity(0.75))
			.foregroundColor(LightTheme.Colors.error)
			.font(LightTheme.Typography.body1)
			.cornerRadius(30.0)
		
	}
	
	var FramesCount: some View {
		
		ZStack {
			
			RoundedRectangle(cornerRadius: 10, style: .continuous)
				.fill(LightTheme.Colors.uiSurface)
				.frame(width: UIScreen.screenWidth * 0.3, height: 70)
			
			Text(String(viewModel.clanDetails.frames_total)).foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
			
		}.background(LightTheme.Colors.uiSurface).frame(width: UIScreen.screenWidth * 0.5, height: 50).cornerRadius(10)
		
	}
	
	var ListOfMembers: some View {
		
		ZStack {
			
			VStack {
				
				Spacer().frame(height: 20)
				
				ForEach(viewModel.clanDetails.users, id: \.user_id) { item in
					
					HStack(alignment: .center) {
						
						Spacer().frame(width: 20)
						
						KFImage.url(URL(string: item.display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55).cornerRadius(50.0)
						
						Spacer().frame(width: 20)
						
						Text(item.name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
						
						Spacer()
						
					}
					
				}
				
				Spacer().frame(height: 20)
				
			}
			
		}.background(LightTheme.Colors.uiSurface).frame(width: UIScreen.screenWidth * 0.9).cornerRadius(10)
	}
	
	var AddPeopleToClanButtons: some View {
		
		HStack {
			
			ZStack {
				
				RoundedRectangle(cornerRadius: 20, style: .continuous)
					.fill(LightTheme.Colors.appLead)
					.frame(width: 150, height: 50)
				
				Text("add friends").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
				
			}.onPress {
				
				self.showAddFriendsModal = true
			}
			
			ZStack {
				
				RoundedRectangle(cornerRadius: 20, style: .continuous)
					.fill(LightTheme.Colors.appLead.opacity(0.25))
					.frame(width: 150, height: 50)
				
				Text("invite friends").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
				
			}.onPress {
				
				self.showInviteFriendsModal = true
			}
			
		}.sheet(isPresented: $showAddFriendsModal) {
			
			MyProfileScreen()
			
		}.sheet(isPresented: $showInviteFriendsModal) {
			
			MyProfileScreen()
		}
	}
	
	var QuitButton: some View {
		
		ZStack {
			
			RoundedRectangle(cornerRadius: 20, style: .continuous)
				.fill(LightTheme.Colors.error.opacity(0.25))
				.frame(width: 150, height: 50)
			
			Text("quit clan").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
			
		}.onPress {
			
			self.showingQuitClanPopup = true
		}
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

//struct ClanHubScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ClanHubScreen()
//    }
//}
