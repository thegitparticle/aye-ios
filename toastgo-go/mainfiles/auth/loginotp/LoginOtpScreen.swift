//
//  LoginOtpScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI
import SwiftUIKitView
import SwiftUIX
import PopupView
import AudioToolbox

struct LoginOtpScreen: View {
	
	var phoneNumber: String
	var countryCode: String
	@State var otpPassword = ""
	@State var showSpinner: Bool = false
	@State var showingErrorPopup = false
	@ObservedObject var textFieldManager = TextFieldManager()
	
	var body: some View {
		ZStack(alignment: .leading) {
			VStack(alignment: HorizontalAlignment.leading) {
				
				ScreenHeader()
				
				HStack(alignment: .center) {
					CocoaTextField("", text: $textFieldManager.userInput).isFirstResponder(true).keyboardType(.decimalPad).frame(width: 100, height: 40).padding().foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body2).background(LightTheme.Colors.textSecondary.opacity(0.75)).cornerRadius(10)
				}.padding(20).frame(maxWidth: .infinity)
				
				HStack(alignment: .center) {
					CircleIconAuthFlow(size: 17, iconName: .ios_arrow_round_forward)
				}.padding(20).frame(maxWidth: .infinity).onPress {
//					viewModel.checkPhoneNumber(phone: self.countryCode + self.phoneNumber)
					print("debuglogs", self.otpPassword)
					self.showSpinner = true
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).popup(isPresented: $showingErrorPopup, autohideIn: 5) {
			ErrorOtpContent()
}
	}
}

class TextFieldManager: ObservableObject {
	
	let characterLimit = 4
	
	@Published var userInput = "" {
		didSet {
			if userInput.count > characterLimit {
				userInput = String(userInput.prefix(characterLimit))
				AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
			}
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
				Text("Yo! you're back").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h4).padding(20)
				Text("tell me otp to prove it's you").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body1).padding(20)
			}
		}
	}
}
	
private struct ErrorOtpContent: View {
		
		var body: some View {
			Text("wrong otp, try again")
				.frame(width: 300, height: 100)
				.background(LightTheme.Colors.textSecondary.opacity(0.75))
				.foregroundColor(LightTheme.Colors.error)
				.cornerRadius(30.0)
		}
	}

struct LoginOtpScreen_Previews: PreviewProvider {
	static var previews: some View {
		LoginOtpScreen(phoneNumber: "+919849167641", countryCode: "+91")
	}
}
