//
//  TalkScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/16/21.
//

import SwiftUI

struct TalkScreen: View {
	
	var clubName: String
	var clubId: Int
	var channelId: String
	var ongoingFrame: Bool
	var startTime: String
	var endTime: String
	var ongoingStream: Bool
	var ongoingStreamUser: String
	var directornot: Bool
	
	
	var body: some View {
		
		
		ZStack(alignment: .top) {
			
			VStack {
				
				Text(clubName).foregroundColor(LightTheme.Colors.textSecondary).font(LightTheme.Typography.h4).padding(20)
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			
			HeaderHere(titleText: clubName)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
	
}

private struct HeaderHere: View {
	
	var titleText: String
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	var body: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground).shadow(color: LightTheme.Colors.textSecondary.opacity(0.05), radius: 40, x: 0, y: 10)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					CircleIcon(size: 13, iconName: .ios_apps).padding(.horizontal, 20)
					
					Spacer()
					
					Text(titleText).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
					
					Spacer()
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_arrow_down).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
	}
}

struct TalkScreen_Previews: PreviewProvider {
	static var previews: some View {
		TalkScreen(clubName: "", clubId: 0, channelId: "", ongoingFrame: false, startTime: "", endTime: "", ongoingStream: false, ongoingStreamUser: "", directornot: false)
	}
}
