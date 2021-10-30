//
//  EnterPhoneScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI
//import SwiftUIKitView
import CountryPicker
import SwiftUIX
import PopupView

struct EnterPhoneScreen: View {
	@StateObject private var viewModel = EnterPhoneViewModel()
	
	var countryCodeHere: String = ""
	@State var phoneNumber = ""
	@State var y : CGFloat = 150
	@State var countryCode = "+91"
	@State var countryFlag = "🇮🇳"
	@State var showSpinner: Bool = false
	@State var showingErrorPopup = false
	@State private var activateEnterDetailsNav = false
	@State private var activateLoginOtpNav = false
	
	var body: some View {
		ZStack(alignment: .leading) {
			VStack(alignment: HorizontalAlignment.leading) {
				NavigationLink(destination: EnterDetailsScreen(phoneNumber: self.phoneNumber, countryCode: self.countryCode), isActive: self.$activateEnterDetailsNav) {EmptyView()}
				
				NavigationLink(destination: LoginOtpScreen(phoneNumber: self.phoneNumber, countryCode: self.countryCode), isActive: self.$activateLoginOtpNav) {EmptyView()}
				
				ScreenHeader()
				
				HStack(spacing: 0) {
					Text(countryCode.isEmpty ? "🇮🇳 +91" : "\(countryFlag) +\(countryCode)").frame(width: 80, height: 50)
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
					CocoaTextField("phone number", text: $phoneNumber).isFirstResponder(true).keyboardType(.phonePad).frame(width: 250, height: 50).padding().foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body2)
				}.padding(20).onChange(of: viewModel.phoneCheck, perform: {phoneStatus in onClickNextButton(status: phoneStatus)})
				
				HStack(alignment: .center) {
					CircleIconAuthFlow(size: 17, iconName: .ios_arrow_round_forward)
				}.padding(20).frame(maxWidth: .infinity).onPress {
					viewModel.checkPhoneNumber(phone: self.countryCode + self.phoneNumber)
					print("debuglogs", self.countryCode + self.phoneNumber)
					print("debuglogs code", self.countryCode)
					self.showSpinner = true
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			CountryCodePickerUI(countryCode: $countryCode, countryFlag: $countryFlag, y: $y)
				.offset(y: y)
			HStack(alignment: .center) {
				ProgressView().visible(showSpinner)
			}.frame(maxWidth: .infinity)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).popup(isPresented: $showingErrorPopup, autohideIn: 5) {
			ErrorPhoneNumberContent()
		}
	}
	
	func onClickNextButton (status: String) {
		if (status == "False") {
			print("debuglogs code", "totally new user")
			self.activateEnterDetailsNav = true
			self.showSpinner = false
		} else if (status == "True") {
			print("debuglogs code", "you re back?")
			self.activateLoginOtpNav = true
			self.showSpinner = false
		} else {
			print("debuglogs code", "api error")
			self.showingErrorPopup = true
			self.showSpinner = false
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
				Text("Hey there!").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h4).padding(20)
				Text("tell me your phone number").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body1).padding(20)
			}
		}
	}
}

private struct ErrorPhoneNumberContent: View {
	
	var body: some View {
		Text("please check your number and try again")
			.frame(width: 300, height: 100)
			.background(LightTheme.Colors.textSecondary.opacity(0.75))
			.foregroundColor(LightTheme.Colors.error)
			.cornerRadius(30.0)
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
