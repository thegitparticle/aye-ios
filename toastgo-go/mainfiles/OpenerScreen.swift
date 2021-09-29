//
//  OpenerScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct OpenerScreen: View {
	
	@State var showSplash = true
	
    var body: some View {
		ZStack{
        Text("the open, into the verse!")
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
}

struct OpenerScreen_Previews: PreviewProvider {
    static var previews: some View {
        OpenerScreen()
    }
}
