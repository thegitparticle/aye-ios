//
//  EnterPhoneScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI
import SwiftUIKitView
import CountryPicker
import SwiftUIX

struct EnterPhoneScreen: View {
	@StateObject private var viewModel = EnterPhoneViewModel()
	
	var countryCodeHere: String = ""
	@State var phoneNumber = ""
	@State var y : CGFloat = 150
	@State var countryCode = "+91"
	@State var countryFlag = "🇮🇳"
	@State var showSpinner: Bool = false
	
	var body: some View {
		ZStack(alignment: .leading) {
			ZStack {
				VStack(alignment: HorizontalAlignment.leading) {
					ScreenHeader()
					HStack (spacing: 0) {
						Text(countryCode.isEmpty ? "🇮🇳 +91" : "\(countryFlag) +\(countryCode)")
							.frame(width: 80, height: 50)
							.background(Color.secondary.opacity(0.2))
							.cornerRadius(10)
							.foregroundColor(LightTheme.Colors.uiBackground)
							.font(LightTheme.Typography.body1)
							.onTapGesture {
								UIApplication.shared.endEditing()
								withAnimation (.spring()) {
									self.y = 0
								}
							}
						CocoaTextField("phone number", text: $phoneNumber).isFirstResponder(true).keyboardType(.phonePad).frame(width: 250, height: 50).padding().foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body1)
					}.padding(20).onChange(of: viewModel.phoneCheck, perform: {phoneStatus in if (phoneStatus == "False") {
						print("debuglogs code", "totally new user")
					} else if (phoneStatus == "True") {
						print("debuglogs code", "you re back?")
					} else {
						print("debuglogs code", "api error")
					}
					
					})
					HStack(alignment: .center) {
						CircleIconAuthFlow(size: 17, iconName: .ios_arrow_round_forward)
					}.padding(20).frame(maxWidth: .infinity).onPress {
						viewModel.checkPhoneNumber(phone: self.countryCode + self.phoneNumber)
						print("debuglogs", self.countryCode + self.phoneNumber)
						print("debuglogs code", self.countryCode)
						self.showSpinner = true
					}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
				CountryCodePickerUI(countryCode: $countryCode, countryFlag: $countryFlag, y: $y)
					.offset(y: y)
				ProgressView().visible(showSpinner)
			}
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
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
				Text("Hey there!").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h4).padding(20)
				Text("tell me your phone number").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body1).padding(20)
			}
		}
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

struct EnterPhoneScreen_Previews: PreviewProvider {
	static var previews: some View {
		EnterPhoneScreen()
	}
}

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
