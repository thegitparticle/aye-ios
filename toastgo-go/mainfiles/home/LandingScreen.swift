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
							
							VStack {
								
								MyClansScreen()
								
//								Text("now, you are inside the clan!").font(LightTheme.Typography.h1).foregroundColor(LightTheme.Colors.textPrimary)
//								Text("now, you are inside the clan!").font(LightTheme.Typography.h3).foregroundColor(LightTheme.Colors.textPrimary)
//								Text("now, you are inside the clan!").font(LightTheme.Typography.body2).foregroundColor(LightTheme.Colors.textPrimary)
//								Spacer()
//								Text("now, you are inside the clan!").font(LightTheme.Typography.subtitle2).foregroundColor(LightTheme.Colors.textPrimary)
//								Text("now, you are inside the clan!").font(.system(size: 13)).foregroundColor(LightTheme.Colors.textPrimary)
//								Text("now, you are inside the clan!").font(LightTheme.Typography.subtitle2I).foregroundColor(LightTheme.Colors.textPrimary)
//								Spacer()
							}.padding(.top , 100)
							
						} else {
							
							VStack {
								
								MyDirectsScreen()
								
							}.padding(.top, 100)
						}
					}
					
				}
				.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			
			HeaderHere()
			
			TabBarView(index: $index)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
	
}

private struct HeaderHere: View {
	
	var body: some View {
		
		VStack (alignment: .center) {
			
			Spacer(minLength: statusBarHeight)
			
			HStack () {
				
				CircleIcon(size: 13, iconName: .ios_person_add).padding(.horizontal, 20)
				
				Spacer()
				
				CircleIcon(size: 13, iconName: .ios_rocket)
				
				Spacer()
				
				CircleIcon(size: 13, iconName: .ios_person).padding(.horizontal, 20)
			}
			
		}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground)
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
