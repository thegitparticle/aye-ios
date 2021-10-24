//
//  LandingScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

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
							
							MyClansScreen(clansListHere: viewModel.clanHere, liveClansHere: viewModel.liveClansHere, my_id: viewModel.userDeetsHere.user.id, my_name: viewModel.userDeetsHere.user.full_name, refreshFunction: self.refreshLandingViewModelHere)
							
						} else {
							
							MyDirectsScreen(directsListHere: viewModel.directsHere, nudgeListHere: viewModel.nudgeListHere, my_id: viewModel.userDeetsHere.user.id, my_name: viewModel.userDeetsHere.user.full_name, refreshFunction: self.refreshLandingViewModelHere)
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
	
	var body: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground).shadow(color: LightTheme.Colors.textSecondary.opacity(0.05), radius: 40, x: 0, y: 10)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					CircleIcon(size: 13, iconName: .ios_person_add).padding(.horizontal, 20)
					
					Spacer()
					
					CircleIcon(size: 13, iconName: .ios_rocket)
					
					Spacer()
					
					CircleIcon(size: 13, iconName: .ios_person).padding(.horizontal, 20).onPress {
						self.showMyProfileModal = true
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
			
		}.sheet(isPresented: $showMyProfileModal) {
			MyProfileScreen()
		}
	}
}

struct TabBarView: View {
	@Binding var index: Int
	var titles = ["Home", "Directs"]
	var body: some View {
		HStack {
			ForEach(titles.indices) {id in
				let title = Text(titles[id]).id(id).foregroundColor(LightTheme.Colors.textSecondary).font(LightTheme.Typography.h4).padding(20)
					.onTapGesture {
						withAnimation() {
							index = id
						}
					}
				if self.index == id {
					title.foregroundColor(.black)
				} else {
					title.foregroundColor(.gray)
				}
			}
		}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom).padding(40)
	}
	private let leftOffset: CGFloat = 0.1
}

struct LandingScreen_Previews: PreviewProvider {
	static var previews: some View {
		LandingScreen()
	}
}


struct Book: Identifiable {
	var id = UUID()
	var title: String
	var author: String
	var isbn: String
	var pages: Int
	var isRead: Bool = false
}
extension Book {
	static let samples = [
		Book(title: "Changer", author: "Matt Gemmell", isbn: "9781916265202", pages: 476),
		Book(title: "SwiftUI for Absolute Beginners", author: "Jayant Varma", isbn: "9781484255155", pages: 200),
		Book(title: "Why we sleep", author: "Matthew Walker", isbn: "9780141983769", pages: 368),
		Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", isbn: "9780671461492", pages: 216)
	]
}
