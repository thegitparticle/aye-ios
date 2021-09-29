//
//  OpenerScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct OpenerScreen: View {
	
	@State var showSplash = true
	
	@State private var loginState = UserDefaults.standard.integer(forKey: "LoginState")
	
	var body: some View {
		NavigationView {
			ZStack{
				if (loginState != 0) {
					LandingScreen()
				} else {
					WelcomeScreen()
				}
				SplashScreen()
					.opacity(showSplash ? 1 : 0)
					.onAppear {
						DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
							withAnimation() {
								self.showSplash = false
							}
						}
					}
			}
		}
		.navigationBarHidden(true)
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct OpenerScreen_Previews: PreviewProvider {
	static var previews: some View {
		OpenerScreen()
	}
}
