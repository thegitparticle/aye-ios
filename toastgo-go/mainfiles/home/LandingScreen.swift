//
//  LandingScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI
import SwiftUIFontIcon
import BottomSheet
import Kingfisher

let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

struct LandingScreen: View {
	@StateObject private var viewModel = LandingScreenViewModel()
	
	@State var index = 0
	
	var body: some View {
		ZStack(alignment: .top) {
			
			VStack {
				
				TabView(selection: $index) {
					
					ForEach (0..<2) { pageId in
						
						if (pageId == 0) {
							
							MyClansScreen(clansListHere: viewModel.clanHere, liveClansHere: viewModel.liveClansHere, my_id: viewModel.userDeetsHere.user.id, my_name: viewModel.userDeetsHere.user.full_name, refreshFunction: self.refreshLandingViewModelHere).onReceive(NotificationCenter.default.publisher(
								for: UIApplication.willEnterForegroundNotification
							)) { _ in
								viewModel.refreshLandingViewModel()
								print("onresumecheck on resume refreshing apis - clans side")
							}.onAppear() {
								
								viewModel.refreshLandingViewModel()
								print("onresumecheck on resume refreshing apis - clans side appear")
							}
							
						} else {
							
							MyDirectsScreen(directsListHere: viewModel.directsHere, nudgeListHere: viewModel.nudgeListHere, my_id: viewModel.userDeetsHere.user.id, my_name: viewModel.userDeetsHere.user.full_name, refreshFunction: self.refreshLandingViewModelHere).onReceive(NotificationCenter.default.publisher(
								for: UIApplication.willEnterForegroundNotification
							)) { _ in
								viewModel.refreshLandingViewModel()
								print("onresumecheck on resume refreshing apis - directs side")
							}.onAppear() {
								
								viewModel.refreshLandingViewModel()
								print("onresumecheck on resume refreshing apis - directs side appear")
							}
						}
					}
					
				}
				.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			
			HeaderHere()
			
			TabBarView(index: $index)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
	
	func refreshLandingViewModelHere () -> Bool {
		
		viewModel.refreshLandingViewModel()
		
		print("refreshed")
		
		return true
	}
	
}

private struct HeaderHere: View {
	
	@State private var showMyProfileModal = false
	@State private var showInvitePeopleModal = false
	@State private var showTheAyeModal = false
	
	var body: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground).shadow(color: LightTheme.Colors.textSecondary.opacity(0.05), radius: 40, x: 0, y: 10)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					CircleIconSFSymbols(size: 11, iconName: "person.badge.plus").padding(.horizontal, 20).onPress {
						self.showInvitePeopleModal = true
					}
					
					Spacer()
					
					Image("sup_in_red")
						.resizable()
						.scaledToFit()
						.frame(width: 60, height: 26).onPress {
							self.showTheAyeModal = true
						}
					
					Spacer()
					
					DPShow.onPress {
						self.showMyProfileModal = true
					}
					
				}.padding(.bottom, 45)
				
			}.frame(maxWidth: .infinity, maxHeight: 120, alignment: .top)
			
		}.sheet(isPresented: $showMyProfileModal) {
			MyProfileScreen()
		}.sheet(isPresented: $showInvitePeopleModal) {
			InviteContactsScreen()
		}.sheet(isPresented: $showTheAyeModal) {
			TheAyeScreen()
		}
	}
	
	var DPShow: some View {
		
		KFImage.url(URL(string: UserDefaults.standard.string(forKey: "MyDp") ?? "")!).resizable().cornerRadius(17.5).frame(width: 35, height: 35).cornerRadius(50.0).padding()
		
	}
}

private struct StreamSheetContent: View {
	
	@StateObject private var viewModel = LandingScreenViewModel()
	
	var body: some View {
		
		List {
			Section(header: Text("Clans").foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)) {
				
				VStack(alignment: .leading) {
					
					ForEach(viewModel.liveClansHere , id: \.club_id) {item in
						
						HStack {
							
							Text(item.club_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 10)
							
							Spacer()
							
							Text("frame ongoing").foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 10)
							
							
							
						}.frame(width: .infinity)
						
					}
					
					ForEach(viewModel.clanHere, id: \.club_id) {item in
						
						
						Text(item.club_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 10)
						
						
					}
					
				}
				
			}
			
			Section(header: Text("Directs").foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)) {
				
				VStack(alignment: .leading) {
					
					ForEach(viewModel.directsHere , id: \.direct_channel_id) {item in
						
						if (item.ongoing_frame) {
							
							HStack {
								
								Text(item.display_guys.full_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 10)
								
								Text("live frame").foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 10)
								
							}.frame(width: .infinity)
							
						} else {
							
							Text(item.display_guys.full_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 10)
							
						}
						
					}
					
				}
				
			}
		}
		
	}
	
	
}

struct TabBarView: View {
	
	@Binding var index: Int
	
	var titles = ["Home", "Directs"]
	
	@State var showStreamBottomSheet = false
	
	var body: some View {
		
		HStack {
			
			ZStack {
				
				HStack(spacing: .some(90)) {
					
					ForEach(titles.indices) { id in
						
						let title = Image(systemName: (titles[id] == "Home") ? "house.fill" : "paperplane.fill").onTapGesture {
							withAnimation() {
								index = id
							}
						}
						
						if self.index == id {
							
							title.foregroundColor(LightTheme.Colors.textPrimary)
							
						} else {
							
							title.foregroundColor(LightTheme.Colors.textPrimary.opacity(0.5))
							
						}
						
					}
					
				}.frame(width: 210, height: 60, alignment: .center).background(LightTheme.Colors.uiSurface).shadow(color: LightTheme.Colors.textSecondary.opacity(0.25), radius: 40, x: 0, y: 10).cornerRadius(30)
				
				HStack() {
					
					ZStack() {
						
						Circle().frame(width: 60, height: 60)
							.padding()
							.foregroundColor(LightTheme.Colors.sucesss)
							.background(LightTheme.Colors.sucesss)
							.cornerRadius(70)
						
						FontIcon.text(.ionicon(code: .ios_add), fontsize: 35).foregroundColor(LightTheme.Colors.uiBackground)
					}.onPress {
						self.showStreamBottomSheet = true
					}
					
				}.frame(width: 60, height: 60, alignment: .center).shadow(color: LightTheme.Colors.textSecondary.opacity(0.25), radius: 40, x: 0, y: 10).cornerRadius(30)
				
			}
			
		}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom).padding(.vertical, 50).bottomSheet(isPresented: self.$showStreamBottomSheet, height: UIScreen.screenHeight * 0.5) {
			StreamSheetContent()
		}
		
	}
	
	private let leftOffset: CGFloat = 0.1
}

struct LandingScreen_Previews: PreviewProvider {
	static var previews: some View {
		LandingScreen()
	}
}
