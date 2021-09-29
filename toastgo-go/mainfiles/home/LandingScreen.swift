//
//  LandingScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct LandingScreen: View {
	
	@State private var buttonActive: Bool = false
	
    var body: some View {
		VStack() {
			Text("now, you are inside the ayeverse!").bold().font(.headline)
			Spacer()
			NavigationLink(destination: WelcomeScreen(),  isActive: $buttonActive) {
				Button(action: {
					UserDefaults.standard.set(false, forKey: "LoginState");
					buttonActive = true
				}) {
					Text("logout").foregroundColor(Color.red)
				}
			}
		}
		.navigationBarHidden(true)
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
