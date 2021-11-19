//
//  InviteContactsScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/25/21.
//

import SwiftUI

struct InviteContactsScreen: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@StateObject private var viewModel = InviteContactsViewModel()
	
	@State var showingCurrentOverlayPopup = false
	
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
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).popup(isPresented: $showingCurrentOverlayPopup) {
			
			CurrentOverlay()
		}.onAppear() {
			
			self.showingCurrentOverlayPopup = true
		}
		
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

struct ContactItemComponent: View {
	
	var name: String
	var phone: String
	
	@State private var checkedThisItem = false
	
	var body: some View {
		
		HStack() {
			
			Spacer().frame(width: 20)
			
			Toggle("", isOn: self.$checkedThisItem)
				.toggleStyle(CheckboxToggleStyle(style: .square))
				.foregroundColor(.blue)
			
			Spacer().frame(width: 20)
			
			Text(self.name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 3)
			
			Spacer()
			
			
		}.frame(width: UIScreen.screenWidth).padding(.vertical, 10)
		
	}
}

struct CurrentOverlay: View {
	
	var body: some View {
		
			Text("we are currently onboarding users slowly. you'd be able to invite soon!")
				.frame(width: 300, height: 100)
				.background(LightTheme.Colors.uiSurface.opacity(0.75))
				.foregroundColor(LightTheme.Colors.error)
				.font(LightTheme.Typography.body1)
				.cornerRadius(30.0)
		
	}
}

struct InviteContactsScreen_Previews: PreviewProvider {
	static var previews: some View {
		InviteContactsScreen()
	}
}
