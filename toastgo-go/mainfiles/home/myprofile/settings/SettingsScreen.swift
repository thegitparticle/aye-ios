//
//  SettingsScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import SwiftUI

struct SettingsScreen: View {
	
	var changeCurrentShowingView: () -> ()
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				VStack (alignment: .center) {
				
				IconButtonForOptions(title: "Privacy Policy", iconName: .ios_brush, size: 20, color: LightTheme.Colors.textSecondary)
				
				IconButtonForOptions(title: "T & C", iconName: .ios_brush, size: 20, color: LightTheme.Colors.textSecondary)
				
				IconButtonForOptions(title: "Log Out", iconName: .ios_settings, size: 20, color: LightTheme.Colors.error).onPress {
					
					UserDefaults.standard.set(false, forKey: "LoginState");
					
				}
					
				}.frame(width: UIScreen.screenWidth)
				
				
			}.frame(maxWidth: UIScreen.screenWidth, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(LightTheme.Colors.uiBackground)
			
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
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
						
						self.changeCurrentShowingView()
					}
					
					Spacer()
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
}

//struct SettingsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsScreen()
//    }
//}
