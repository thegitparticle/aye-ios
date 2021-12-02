//
//  EnterDetailsScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI
import SwiftUIKitView
import SwiftUIX
import PopupView
import AudioToolbox

struct EnterDetailsScreen: View {
	@StateObject private var viewModel = EnterDetailsViewModel()
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	var phoneNumber: String
	var countryCode: String
	
	@State var showSpinner: Bool = false
	@State var showingErrorPopup = false
	
	@State private var activateSignUpOtpNav = false
	
	@ObservedObject var textFieldManagerName = TextFieldManagerEnterDetails()
	@ObservedObject var textFieldManagerUsername = TextFieldManagerEnterDetails()
	
	@State private var textFullName = ""
	@State private var textUserName = ""
	
	var body: some View {
		ZStack(alignment: .leading) {
			VStack(alignment: HorizontalAlignment.leading) {
				
				NavigationLink(destination: SignupOtpScreen(), isActive: self.$activateSignUpOtpNav) {EmptyView()}
				
				ScreenHeader
				
				VStack(alignment: .leading) {
					
					Text("full name").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body1).padding(20)
					
					VStack (alignment: .center) {
						
						TextField("full name", text: $textFullName).frame(width: UIScreen.screenWidth * 0.9, height: 60).foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body2).background(LightTheme.Colors.textSecondary.opacity(0.75)).cornerRadius(10).help("full name").padding(.horizontal, 20)
						
					}
					
					Text("username").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body1).padding(20)
					
					VStack (alignment: .center) {
						
						TextField("username", text: $textUserName).frame(width: UIScreen.screenWidth * 0.9, height: 60).foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.body2).background(LightTheme.Colors.textSecondary.opacity(0.75)).cornerRadius(10).help("full name").padding(.horizontal, 20)
						
					}
					
				}
				
				HStack(alignment: .center) {
					
					ZStack {
						
						CircleIconAuthFlow(size: 17, iconName: .ios_arrow_round_forward)
						
						HStack(alignment: .center) {
							
							ProgressView().visible(showSpinner)
							
						}.frame(maxWidth: .infinity)
						
					}
					
				}.padding(20).frame(maxWidth: .infinity).onPress {
					
					self.showSpinner = true
//					self.activateSignUpOtpNav = true
					
					print(countryCode + phoneNumber)
					print(self.textFullName)
					print(self.textUserName)
					
					viewModel.sendDetailsWhileSignUp(phone: countryCode + phoneNumber, full_name: self.textFullName, username: self.textUserName)
					
				}.onChange(of: viewModel.enterDetailsWorked, perform: {apistatus in onClickNextButton(status: apistatus)})
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
			
			HStack(alignment: .center) {
				
				ProgressView().visible(showSpinner).foregroundColor(LightTheme.Colors.sucesss)
			}.frame(maxWidth: .infinity)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).popup(isPresented: $showingErrorPopup, autohideIn: 5) {
			
			DetailsDidntWorkContent()
		}
		
	}
	
	
	func onClickNextButton (status: String) {
		if (status == "Worked") {
			print("debuglogs code", "correct enter details")
			self.activateSignUpOtpNav = true
			self.showSpinner = false
		} else if (status == "Wrong") {
			print("debuglogs code", "wrong enter details")
			self.showingErrorPopup = true
			self.showSpinner = false
		} else {
			self.showSpinner = false
		}
	}
	
	var ScreenHeader: some View {
		
		VStack(alignment: HorizontalAlignment.leading) {
			
			Spacer().frame(height: 40)
			
			HStack() {
				
				CircleIconAuthFlow(size: 17, iconName: .ios_arrow_back)
				
				Spacer()
				
			}.padding(20).onPress {
				
				self.mode.wrappedValue.dismiss()
			}
			
			Spacer().frame(height: 40)
			
		}.frame(width: UIScreen.screenWidth)
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

class TextFieldManagerEnterDetails: ObservableObject {
	
	let characterLimit = 12
	
	@Published var userInput = "" {
		didSet {
			if userInput.count > characterLimit {
				userInput = String(userInput.prefix(characterLimit))
				AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
			}
		}
	}
	
}
