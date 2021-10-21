//
//  FramesListScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/21/21.
//

import SwiftUI
import SwiftUIFontIcon

struct FramesListScreen: View {
	
	@StateObject private var viewModel = TalkViewModel()
	@StateObject private var pubnubSetUp = PubnubSetup()
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
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
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack {
				
				MonthChanger
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	var MonthChanger: some View {
		
		HStack {
			
			FontIcon.text(.ionicon(code: .ios_arrow_back), fontsize: 25).foregroundColor(LightTheme.Colors.uiSurface)
			
			Spacer()
			
			Text("MONTH").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
			
			Spacer()
			
			FontIcon.text(.ionicon(code: .ios_arrow_forward), fontsize: 25).foregroundColor(LightTheme.Colors.uiSurface)
			
		}.frame(width: .infinity, height: 100).padding(20)
	}
	
	var HeaderHere: some View {
		
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
					
					Text(clubName).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
					
					Spacer()
					
					HStack {
						
						Circle().frame(width: 20, height: 20)
							.padding()
							.foregroundColor(LightTheme.Colors.uiBackground)
							.background(LightTheme.Colors.uiBackground)
							.cornerRadius(70)
						
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
	}
	
}

//struct FramesListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FramesListScreen()
//    }
//}
