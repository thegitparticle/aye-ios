//
//  EditProfileScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import SwiftUI
import Kingfisher

struct EditProfileScreen: View {
	
	var dpLink: String
	var changeCurrentShowingView: ()
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				IconButtonForOptions(title: "Edit Profile", iconName: .ios_brush, size: 30, color: LightTheme.Colors.sucesss)
				
				Spacer().frame(height: 50)
				
				KFImage.url(URL(string: self.dpLink)).resizable().cornerRadius(22.5).frame(width: 55, height: 55).cornerRadius(50.0)
				
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(LightTheme.Colors.uiBackground)
			
			
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
						
						self.changeCurrentShowingView
					}
					
					Spacer()
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
}

//struct EditProfileScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileScreen()
//    }
//}
