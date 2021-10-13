//
//  LoginSettingUpScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct LoginSettingUpScreen: View {
	
	var phoneNumber: String
	var countryCode: String
	
	@State private var contactsButtonActive: Bool = false
	
	var body: some View {
		ZStack(alignment: .leading) {
			
			VStack() {
				
				Spacer()
				
				LottieView(filename: "contacts_lottie")
				
				Text("setting up your profile!").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
				
				Spacer()
				
				Button(action: {
					//						UserDefaults.standard.set(true, forKey: "LoginState");
					contactsButtonActive = true
				}) {
					Text("allow contacts")
						.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 40)
						.padding()
						.font(LightTheme.Typography.h5)
						.foregroundColor(LightTheme.Colors.uiSurface)
						.background(LightTheme.Colors.textSecondary)
						.cornerRadius(50)
				}
				.padding(.vertical)
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
}

struct LoginSettingUpScreen_Previews: PreviewProvider {
	static var previews: some View {
		LoginSettingUpScreen(phoneNumber: "+919849167641", countryCode: "+91")
	}
}
