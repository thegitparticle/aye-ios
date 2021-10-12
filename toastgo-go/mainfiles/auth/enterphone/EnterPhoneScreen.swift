//
//  EnterPhoneScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI
import SwiftUIKitView
import CountryPicker

struct EnterPhoneScreen: View {
	var body: some View {
		ZStack(alignment: .leading) {
			PlayPart()
		}
		.navigationBarHidden(true)
		.background(LightTheme.Colors.textPrimary)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.edgesIgnoringSafeArea(.all)
	}
}

struct PlayPart: View {
	
	var countryCodeHere: String = ""
	@State var phoneNumber = ""
	@State var y : CGFloat = 150
	@State var countryCode = ""
	@State var countryFlag = ""
	
	var body: some View {
		ZStack {
			VStack(alignment: HorizontalAlignment.leading) {
				Spacer().frame(height: 50)
				HStack() {
					CircleIconAuthFlow()
				}.padding(20)
				Spacer().frame(height: 50)
				VStack(alignment: .leading) {
					Text("Hey there!").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
					Text("tell me your phone number").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body2).padding(20)
				}
				HStack (spacing: 0) {
					Text(countryCode.isEmpty ? "🇦🇺 +61" : "\(countryFlag) +\(countryCode)")
						.frame(width: 80, height: 50)
						.background(Color.secondary.opacity(0.2))
						.cornerRadius(10)
						.foregroundColor(countryCode.isEmpty ? .secondary : .black)
						.onTapGesture {
							withAnimation (.spring()) {
								self.y = 0
							}
						}
					TextField("Phone Number", text: $phoneNumber)
						.padding()
						.frame(width: 200, height: 50)
						.keyboardType(.phonePad)
				}.padding(20)
//				PhoneNumberTextField()
				HStack(alignment: .center) {
					CircleIconAuthFlow()
				}.padding(20).frame(maxWidth: .infinity)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		}
		CountryCodePickerUI(countryCode: $countryCode, countryFlag: $countryFlag, y: $y)
			.offset(y: y)
	}
}

struct PhoneNumberTextField : View {
	@State var phoneNumber = ""
	@State var y : CGFloat = 150
	@State var countryCode = ""
	@State var countryFlag = ""
	var body: some View {
		ZStack {
			HStack (spacing: 0) {
				Text(countryCode.isEmpty ? "🇦🇺 +61" : "\(countryFlag) +\(countryCode)")
					.frame(width: 80, height: 50)
					.background(Color.secondary.opacity(0.2))
					.cornerRadius(10)
					.foregroundColor(countryCode.isEmpty ? .secondary : .black)
					.onTapGesture {
						withAnimation (.spring()) {
							self.y = 0
						}
					}
				TextField("Phone Number", text: $phoneNumber)
					.padding()
					.frame(width: 200, height: 50)
					.keyboardType(.phonePad)
			}.padding(20)
			
			CountryCodePickerUI(countryCode: $countryCode, countryFlag: $countryFlag, y: $y)
				.offset(y: y)
			
			RoundedRectangle(cornerRadius: 10).stroke()
				.frame(width: 280, height: 50)
		}
	}
}

struct EmptyPart: View {
	var body: some View {
		VStack {
			HStack() {
				CircleIconAuthFlow()
			}
			VStack(alignment: .leading) {
				Text("Hey there!").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5)
				Text("tell me your phone number").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body2)
			}
		}
	}
}

struct EnterPhoneScreen_Previews: PreviewProvider {
	static var previews: some View {
		EnterPhoneScreen()
	}
}
