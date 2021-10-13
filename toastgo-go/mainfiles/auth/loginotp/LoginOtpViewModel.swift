//
//  LoginOtpViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/14/21.
//

import Foundation

struct LoginOtpPostApiRequest: Codable {
	var phone: String
	var password: String
}

class LoginOtpViewModel: ObservableObject {
	@Published var otpWorked: Bool = false
	
	public func postOtpToServer(phone: String, password: String) {
		
		let payload = LoginOtpPostApiRequest(phone: phone, password: password)
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/send_otp/\(phone)") else {
			return
		}
		
		var request = URLRequest(url: url)
		
		request.httpMethod = "POST"
//		request.httpBody = payload
		
		do {
			request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
		} catch let error {
			print(error.localizedDescription)
		}
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(PhoneCheckApiResponse.self, from: data) {
					
					DispatchQueue.main.async {
						self.otpWorked = true
						print("debuglogs Fetch worked: \(decodedResponse)")
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
