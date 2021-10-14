//
//  LoginSettingUpScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI
import Contacts

struct ContactInfo : Codable {
	var fullName: String
	var phoneNumber: String
}

struct LoginSettingUpScreen: View {
	
	var phoneNumber: String
	var countryCode: String
	var permissionGiven: Bool = true
	
	@State private var contacts = [ContactInfo.init(fullName: "", phoneNumber: "")]
	
	@State private var contactsButtonActive: Bool = false
	
	var body: some View {
		ZStack(alignment: .leading) {
			
			VStack() {
				
				Spacer()
				
				HStack(alignment: .center) {
					if (contactsButtonActive) {
					LottieView(filename: "contacts_lottie")
					} else {
						LottieView(filename: "loading_ping_pong_cup")
					}
				}.padding(20).frame(maxWidth: .infinity, maxHeight: 200)
				
				Text("setting up your profile!").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
				
				Spacer()
				
				if (contactsButtonActive) {
					Button(action: {
						//						UserDefaults.standard.set(true, forKey: "LoginState");
						contactsButtonActive = true
					}) {
						Text("allow contacts")
							.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 40)
							.padding()
							.font(LightTheme.Typography.h5)
							.foregroundColor(LightTheme.Colors.uiSurface)
							.background(LightTheme.Colors.textSecondary)
							.cornerRadius(50)
					}
					.padding(.vertical)
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity)
			
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
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
			self.contacts = FetchContacts().fetchingContacts()
		}
	}
	
 }


class FetchContacts {
	
	func fetchingContacts() -> [ContactInfo]{
		var contacts = [ContactInfo]()
		let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
		let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
		
		do {
			try CNContactStore().enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
				contacts.append(ContactInfo(fullName: contact.givenName, phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? ""))
			})
		} catch let error {
			print("Failed", error)
		}
		
		print(contacts)
		return contacts
		
	}
}

struct LoginSettingUpScreen_Previews: PreviewProvider {
	static var previews: some View {
		LoginSettingUpScreen(phoneNumber: "+919849167641", countryCode: "+91")
	}
}
