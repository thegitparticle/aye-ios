//
//  EnterPhoneScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct EnterPhoneScreen: View {
	var body: some View {
		VStack(spacing: 0) {
			PlayPart()
			EmptyPart()
		}
		.navigationBarHidden(true)
	}
}

struct PlayPart: View {
	var body: some View {
		GeometryReader { (proxy: GeometryProxy) in
			VStack {
				Text("Subview A").foregroundColor(Style.Test.Background.error)
			}
			.frame(
				width: proxy.size.width,
				height: proxy.size.height / 2
			)
		}
	}
}

struct EmptyPart: View {
	var body: some View {
		VStack {}
	}
}

struct EnterPhoneScreen_Previews: PreviewProvider {
	static var previews: some View {
		EnterPhoneScreen()
	}
}
