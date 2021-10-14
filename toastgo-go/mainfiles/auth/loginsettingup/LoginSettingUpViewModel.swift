//
//  LoginSettingUpViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/14/21.
//

import Foundation

class LoginSettingUpViewModel: ObservableObject {
	@Published var contactsSycned: String = ""
	
	public func postOtpToServer(userid: String, countryCode: String, contactsList: [Any]) {
		
		var payload_before = contactsList
		
		let payload: () = payload_before.append(["country_code", countryCode])
		
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
				if let decodedResponse = try? JSONDecoder().decode(LoginOtpApiResponse.self, from: data) {
					
					DispatchQueue.main.async {
						self.contactsSycned = "Worked"
					}
					return
				} else {
					DispatchQueue.main.async {
						self.contactsSycned = "No"
					}
				}
				DispatchQueue.main.async {
					self.contactsSycned = "No"
				}
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}

}
