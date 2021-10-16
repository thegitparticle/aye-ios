//
//  TalkScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/16/21.
//

import SwiftUI
import SwiftUIFontIcon

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
				
				if (ongoingFrame) {
					
					BottomButtons()
					
				} else {
				
					StartFramePart()
					
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
			
			HeaderHere(titleText: clubName)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
	
}

private struct BottomButtons: View {
	
	var body: some View {
		
		HStack {
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(LightTheme.Colors.textSecondary)
					.background(LightTheme.Colors.textSecondary)
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_camera), fontsize: 25).foregroundColor(LightTheme.Colors.uiSurface)
				
			}.padding(.horizontal, 20)
			
			ZStack {
				
				Circle().frame(width: 35, height: 35)
					.padding()
					.foregroundColor(LightTheme.Colors.sucesss)
					.background(LightTheme.Colors.sucesss)
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_add), fontsize: 70).foregroundColor(LightTheme.Colors.uiSurface)
				
			}.padding(.horizontal, 20)
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(LightTheme.Colors.appLead)
					.background(LightTheme.Colors.appLead)
					.cornerRadius(70)
				
				FontIcon.text(.materialIcon(code: .keyboard), fontsize: 25).foregroundColor(LightTheme.Colors.uiSurface)
				
			}.padding(.horizontal, 20)
		}.padding(.vertical, 30)
		
	}
}

private struct StartFramePart: View {
	
	var body: some View{
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.appLeadVariant).frame(maxWidth: .infinity, maxHeight: 300, alignment: .top).background(LightTheme.Colors.appLeadVariant).cornerRadius(30)
			
			VStack {
				Text("Slide to start a frame").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
				Text("frame lasts for 12 hours").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.caption).padding(20)
				
				SliderComponent(thumbnailColor: Color.red,
								didReachEndAction: { view in
									print("reach end!!")
									DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
										view.resetState()
									}
								})
					.frame(width: 320, height: 56)
					.background(Color.yellow)
					.cornerRadius(28)
			}
			
		}.frame(alignment: .center)
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
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_arrow_back).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Spacer()
					
					Text(titleText).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
					
					Spacer()
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_apps).padding(.horizontal, 20)
						
					}.onPress {
						
						// add nav to frames view
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
