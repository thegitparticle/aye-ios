//
//  EnterDetailsScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct EnterDetailsScreen: View {
	
	var phoneNumber: String
	var countryCode: String
	@State var showSpinner: Bool = false
	@State var showingErrorPopup = false
	
	var body: some View {
		ZStack(alignment: .leading) {
		VStack {
			ScreenHeader()
			Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			Text(self.phoneNumber)
			Text(self.countryCode)
		}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).popup(isPresented: $showingErrorPopup, autohideIn: 5) {
			DetailsDidntWorkContent()
		}
	}
}

private struct ScreenHeader: View {
	
	var body: some View {
		
		VStack(alignment: HorizontalAlignment.leading) {
			Spacer().frame(height: 40)
			HStack() {
				CircleIconAuthFlow(size: 17, iconName: .ios_arrow_back)
			}.padding(20)
			Spacer().frame(height: 40)
			VStack(alignment: .leading) {
				Text("Hey, new friend!").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h4).padding(20)
				Text("tell me about you").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body1).padding(20)
			}
		}
	}
}

private struct DetailsDidntWorkContent: View {
	
	var body: some View {
		Text("username is already in use, try another")
			.frame(width: 300, height: 100)
			.background(LightTheme.Colors.textSecondary.opacity(0.75))
			.foregroundColor(LightTheme.Colors.error)
			.cornerRadius(30.0)
	}
}

struct EnterDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
		EnterDetailsScreen(phoneNumber: "+919849167641", countryCode: "+91")
    }
}
