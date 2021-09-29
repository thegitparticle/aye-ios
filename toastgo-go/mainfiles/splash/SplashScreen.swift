//
//  SplashScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
		VStack() {
			Image("aye_green_grad").resizable().frame(width: 200, height: 111.11)
		}
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		.background(Color.black)
		.edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
