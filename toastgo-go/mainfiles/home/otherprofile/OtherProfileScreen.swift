//
//  OtherProfileScreen.swift
//  toastgo-go
//
//  Created by SAN on 11/28/21.
//

import SwiftUI
import Kingfisher

struct OtherProfileScreen: View {
	
	var otherUserId: Int
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	@StateObject private var viewModel = OtherProfileViewModel()
	
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				UserDeets
				
				Spacer()
				
				BottomButtons
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(LightTheme.Colors.uiBackground).onAppear() {
				
				viewModel.getOtherProfileDetailsHere(otherprofileid: String(otherUserId))
			}
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	var UserDeets: some View {
		
		VStack(alignment: .center) {
			
			ZStack {
				
				Circle()
					.fill(LightTheme.Colors.brand.opacity(0.25))
					.frame(width: 100, height: 100)
				
				
				KFImage.url(URL(string: viewModel.otherProfileDeetsHere.image)).resizable().cornerRadius(50).frame(width: 100, height: 100).cornerRadius(50.0)
				
				
			}
			
			
			Spacer().frame(height: 20)
			
			VStack {
				
				Text(viewModel.otherProfileDeetsHere.user.full_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
				
				Text(viewModel.otherProfileDeetsHere.user.username).foregroundColor(LightTheme.Colors.textPrimary.opacity(0.75)).font(LightTheme.Typography.subtitle2).padding(.horizontal, 10).padding(.vertical, 1)
			}
			
			
		}.padding(.vertical, 30).frame(width: UIScreen.screenWidth)
	}
	
	var BottomButtons: some View {
		
		VStack(alignment: .center) {
			
			IconButtonForOptionsWithInfo(title: "clans", info: String(viewModel.otherProfileDeetsHere.user.number_of_clubs_joined), iconName: .ios_home, size: 20, color: LightTheme.Colors.special1, sfsymboliconcheck: true, sfsymbolicon: "house.fill")
			
			IconButtonForOptionsWithInfo(title: "frames", info: String(viewModel.otherProfileDeetsHere.user.total_frames_participation), iconName: .ios_apps, size: 20, color: LightTheme.Colors.special3, sfsymboliconcheck: false, sfsymbolicon: "")
			
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

//struct OtherProfileScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherProfileScreen()
//    }
//}
