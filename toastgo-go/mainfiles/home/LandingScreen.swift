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
	
	@State var index = 0
	
	var body: some View {
		ZStack(alignment: .top) {
			
			VStack {
				
				TabView(selection: $index) {
					
					ForEach (0..<2) { pageId in
						VStack {
							
							Text("Page \(pageId)").tag(pageId)
							Text("now, you are inside the ayeverse!").font(LightTheme.Typography.h1)
							Text("now, you are inside the ayeverse!").font(LightTheme.Typography.h3)
							Text("now, you are inside the ayeverse!").font(LightTheme.Typography.body2)
							Spacer()
							Text("now, you are inside the ayeverse!").font(LightTheme.Typography.subtitle2)
							Text("now, you are inside the ayeverse!").font(.system(size: 13))
							Text("now, you are inside the ayeverse!").font(LightTheme.Typography.subtitle2I)
							Spacer()
						}
					}
				}
				.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			
			TabBarView(index: $index)
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
	
}

struct TabBarView: View {
	@Binding var index: Int
	var titles = ["Home", "Directs"]
	var body: some View {
		HStack {
			ForEach(titles.indices) {id in
				let title = Text(titles[id]).id(id).foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h4).padding(20)
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
