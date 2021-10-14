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

struct LoginOtpApiResponse: Codable {
	var refresh: String
	var access: String
}


class LoginOtpViewModel: ObservableObject {
	@Published var otpWorked: String = ""
	
	public func postOtpToServer(phone: String, password: String) {
		
		//		let payload2 = LoginOtpPostApiRequest(phone: phone, password: password)
		
		let payload = ["phone": phone, "password": password]
		
		guard let url = URL(string: "https://apisayepirates.life/api/auth/token/") else {
			return
		}
		
		var request = URLRequest(url: url)
		
		//		var urlComponents = URLComponents(string: "")
		//		urlComponents?.queryItems = payload
		//		let request_body = urlComponents!.query!
		
		request.httpMethod = "POST"
		//		request.httpBody = Data(request_body.utf8)
		
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
						self.otpWorked = "Worked"
					}
					return
				} else {
					DispatchQueue.main.async {
						self.otpWorked = "Wrong"
					}
				}
				DispatchQueue.main.async {
					self.otpWorked = "Wrong"
				}
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
