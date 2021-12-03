//
//  SignupSettingUpScreen.swift
//  toastgo-go
//
//  Created by SAN on 12/3/21.
//

import SwiftUI
import Contacts
import CoreLocation

struct SignupSettingUpScreen: View {
	@StateObject private var viewModel = SignupSettingUpViewModel()
	
	var phoneNumber: String
	var countryCode: String
	var userDeets: UserDetailsDataClass
	
	var permissionGiven: Bool = true
	
	@State private var contacts = []
	
	@State private var contactsButtonActive: Bool = false
	@State private var showingSettingsGoingAlert = false
	
	@State private var activateLandingScreenNav = false
	
	var body: some View {
		ZStack(alignment: .leading) {
			
			NavigationLink(destination: CheckInvitedOrNotScreen(phoneNumber: phoneNumber, countryCode: countryCode, userDeets: userDeets), isActive: self.$activateLandingScreenNav) {EmptyView()}
			
			VStack() {
				
				Spacer()
				
				HStack(alignment: .center) {
					if (contactsButtonActive) {
						LottieView(filename: "contacts_lottie")
					} else {
						LottieView(filename: "loading_ping_pong_cup")
					}
				}.padding(20).frame(maxWidth: .infinity, maxHeight: 200)
				
				if (contactsButtonActive) {
					Text("sup? needs contacts to work").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
				} else {
					Text("setting up your profile!").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
				}
				
				Spacer().onAppear() {
					self.requestAccess()
					self.getContacts()
				}
				
				if (contactsButtonActive) {
					Button(action: {
						//						UserDefaults.standard.set(true, forKey: "LoginState");
						contactsButtonActive = true
						self.sendToSettingsForPermissions()
					}) {
						Text("allow contacts in settings")
							.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 40)
							.padding()
							.font(LightTheme.Typography.h5)
							.foregroundColor(LightTheme.Colors.uiSurface)
							.background(LightTheme.Colors.textSecondary)
							.cornerRadius(50)
					}
					.padding(.vertical).padding(20)
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity).onChange(of: viewModel.contactsSycned, perform: {syncStatus in onClickNextButton(status: syncStatus)})
			
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
	}
	
	func onClickNextButton (status: String) {
		if (status == "Worked") {
			
			UserDefaults.standard.set(userDeets.image, forKey: "MyDp");
			UserDefaults.standard.set(userDeets.user.full_name, forKey: "MyName");
			UserDefaults.standard.set(userDeets.user.id, forKey: "MyId");
			UserDefaults.standard.set(userDeets.user.phone, forKey: "MyPhone");
			
			UserDefaults.standard.set(true, forKey: "LoginState");
			
			self.activateLandingScreenNav = true
			
		} else if (status == "No") {
			print("debuglogs code", "contacts upload error")
			self.requestAccess()
			self.getContacts()
		} else {
			
		}
	}
	
	func requestAccess() {
		let store = CNContactStore()
		switch CNContactStore.authorizationStatus(for: .contacts) {
		case .authorized:
			self.getContacts()
			self.contactsButtonActive = false
		case .denied:
			store.requestAccess(for: .contacts) { granted, error in
				if granted {
					self.getContacts()
					self.contactsButtonActive = false
				} else {
					self.contactsButtonActive = true
				}
			}
		case .restricted, .notDetermined:
			store.requestAccess(for: .contacts) { granted, error in
				if granted {
					self.getContacts()
				} else {
					self.contactsButtonActive = true
				}
			}
		@unknown default:
			print("error")
		}
	}
	
	func getContacts() {
		DispatchQueue.main.async {
			self.contacts = FetchContactsWhileSignup().fetchingContacts()
			print("fetched contacts function done")
			if (self.contacts.count > 2) {
				viewModel.postOtpToServerSignup(userid: String(self.userDeets.user.id), countryCode: self.countryCode, contactsList: self.contacts)
			}
			print(self.$contacts)
		}
	}
	
	func sendToSettingsForPermissions() {
		
		UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
	}
	
}


class FetchContactsWhileSignup {
	
	func fetchingContacts() -> [Any]{
		var contacts = [Any]()
		let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
		let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
		
		print("fetched contacts fucntion called and request is setup")
		
		do {
			try CNContactStore().enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
				contacts.append(["name": contact.givenName, "phone": contact.phoneNumbers.first?.value.stringValue ?? ""])
			})
			print("fetched contacts success")
		} catch let error {
			print("Failed", error)
		}
		
		print(contacts)
		return contacts
		
	}
}

