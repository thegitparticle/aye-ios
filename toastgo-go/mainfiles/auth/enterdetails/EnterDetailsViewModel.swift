//
//  EnterDetailsViewModel.swift
//  toastgo-go
//
//  Created by SAN on 12/2/21.
//

import Foundation

class EnterDetailsViewModel: ObservableObject {
	
	@Published var enterDetailsWorked: String = ""
	
	public func sendDetailsWhileSignUp(phone: String, full_name: String, username: String) {
		
		let payload = ["phone": phone, "full_name": full_name, "username": username, "profile": [:]] as [String : Any]
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/register/") else {
			return
		}
		
		var request = URLRequest(url: url)
		
		request.httpMethod = "POST"
		
		do {
			request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
		} catch let error {
			print(error.localizedDescription)
		}
		
		
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let response = response {
				
				self.enterDetailsWorked = "Worked"
				print(response)
			}
			
//			self.enterDetailsWorked = "Wrong"
			print("debuglogs Fetch failed nudge list: \(error?.localizedDescription ?? "Unknown error")")
			
		}.resume()
		
	}
}

