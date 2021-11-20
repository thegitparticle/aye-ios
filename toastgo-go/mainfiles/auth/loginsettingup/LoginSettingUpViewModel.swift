//
//  LoginSettingUpViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/14/21.``
//

import Foundation

class LoginSettingUpViewModel: ObservableObject {
	@Published var contactsSycned: String = ""
	
	public func postOtpToServer(userid: String, countryCode: String, contactsList: [Any]) {
		
		print("post otp to server func called")
		
		print("passed contacts", contactsList)
		
		var payload_2: [Any] = contactsList
		
		payload_2.insert(contentsOf: [["country_code", countryCode]], at: 0)
		
		var jsonHere: Data = Data()
		
		do {
			jsonHere = try JSONSerialization.data(withJSONObject: payload_2, options: [])
		} catch let error {
			print(error.localizedDescription)
		}
		
		var JSONString: String = ""
		
		JSONString = String(data: jsonHere, encoding: String.Encoding.utf8) ?? ""
		
		let payload = ["contact_list": JSONString]
		
		print("paylod", payload)
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/post_contacts_to_server/\(userid)/") else {
			return
		}
	
		var request = URLRequest(url: url)
		
		request.httpMethod = "PUT"
		
		do {
			request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
		} catch let error {
			print(error.localizedDescription)
		}

		request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		URLSession.shared.dataTask(with: request) { data, response, error in

			if let data = data {
				DispatchQueue.main.async {
					self.contactsSycned = "Worked"
				}
				}
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}.resume()
	}
	
//	init () {
//		self.setUserDetailsInStore()
//	}
//	
//	func setUserDetailsInStore () {
//
//		UserDefaults.standard.set(82, forKey: "MyId");
////		UserDefaults.standard.set("san", forKey: "MyName");
////		UserDefaults.standard.set("+919849167641", forKey: "MyPhone");
////		UserDefaults.standard.set(self.userDeets.image, forKey: "MyDp");
//	}
}
