//
//  ClanHubScreen.swift
//  toastgo-go
//
//  Created by SAN on 11/27/21.
//

import SwiftUI
import Kingfisher

struct ClanHubScreen: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@StateObject private var viewModel = ClanHubViewModel()
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					Spacer().frame(height: 30)
				
					FramesCount
					
					Spacer().frame(height: 30)
					
					ListOfMembers
					
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(LightTheme.Colors.uiBackground)
			
//			.popup(isPresented: $showingClansOverlayPopup) {
//
//				ClansOverlay
//
//			}.popup(isPresented: $showingFramesOverlayPopup) {
//
//				FramesOverlay
//			}
			
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	var FramesCount: some View {
		
		ZStack {
			
			Text("77").foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
			
		}.background(LightTheme.Colors.uiSurface).frame(width: UIScreen.screenWidth * 0.5, height: 50).cornerRadius(10)
		
	}
	
	var ListOfMembers: some View {
		
		ZStack {
			
			VStack {
				
				ForEach(viewModel.clanDetails.users, id: \.user_id) { item in
					
					HStack(alignment: .center) {
						
						Spacer().frame(width: 20)
						
						KFImage.url(URL(string: item.display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55).cornerRadius(50.0)
						
						Spacer().frame(width: 20)
						
						Text(item.name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
						
						Spacer()
						
					}
					
				}
				
			}
			
		}.background(LightTheme.Colors.uiSurface).frame(width: UIScreen.screenWidth * 0.9).cornerRadius(10)
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

struct ClanHubScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClanHubScreen()
    }
}
