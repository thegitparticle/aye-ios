//
//  WelcomeScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct WelcomeScreen: View {
	
	@State private var buttonActive: Bool = false
	
    var body: some View {
		ZStack() {
			Image("buildingbg")
				.resizable()
				.aspectRatio(contentMode: .fill)
			VStack() {
				Image("").resizable().frame(width: 200, height: 111.11)
				Spacer()
				Image("aye_green_grad").resizable().frame(width: 200, height: 111.11)
				Spacer()
				NavigationLink(destination: EnterPhoneScreen(),  isActive: $buttonActive) {
					Button(action: {
//						UserDefaults.standard.set(true, forKey: "LoginState");
						buttonActive = true
					}) {
						Text("dive in")
							.frame(minWidth: 0, maxWidth: 200)
							.padding()
							.foregroundColor(.white)
							.background(Color.gray)
							.cornerRadius(40)
					}
					.padding(.vertical)
				}
			}
		}
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		.background(Color.black)
		.edgesIgnoringSafeArea(.all)
		.navigationBarHidden(true)
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
