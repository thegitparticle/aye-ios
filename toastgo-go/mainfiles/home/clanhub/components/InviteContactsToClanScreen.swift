//
//  InviteContactsToClanScreen.swift
//  toastgo-go
//
//  Created by SAN on 11/28/21.
//

import SwiftUI

struct InviteContactsToClanScreen: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@StateObject private var viewModel = ClanHubViewModel()
	
	@State var showingInvitingOrDonePopup = false
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .leading) {
				
				ScrollView {
					
					LazyVStack(alignment: .leading) {
						
						ForEach(Array(Set(viewModel.contactsList)), id: \.self) {item in
							
							ContactItemComponent(name: item.name, phone: item.phone).id(UUID())
							
						}
						
						
					}
					
				}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top).padding(.top, 150)
				
			}.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
			
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	var HeaderHere: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(width: UIScreen.screenWidth, height: 150, alignment: .top).background(LightTheme.Colors.uiBackground)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}.padding(.bottom, 25)
					
					Spacer()
					
				}
				
			}.frame(width: UIScreen.screenWidth, height: 150, alignment: .top)
		}
		
	}
}

struct InviteContactsToClanScreen_Previews: PreviewProvider {
    static var previews: some View {
        InviteContactsToClanScreen()
    }
}
