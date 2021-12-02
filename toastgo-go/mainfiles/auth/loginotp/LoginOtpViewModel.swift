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
	
	@Published var userDeetsHere: UserDetailsDataClass = UserDetailsDataClass(bio: "", id: 0, image: "", user: User(phone: "", number_of_clubs_joined: 0, contact_list_sync_status: false, id: 0, country_code_of_user: "", username: "", clubs_joined_by_user: "", full_name: "", total_frames_participation: 0, contact_list: ""))
	
	public func postOtpToServer(phone: String, password: String) {
		
		//		let payload2 = LoginOtpPostApiRequest(phone: phone, password: password)
		
		let payload = ["phone": phone, "password": password]
		
		guard let url = URL(string: "https://apisayepirates.life/api/auth/token/") else {
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
	
	
	public func getUserDetails(phone: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/profile/\(phone)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(UserDetailsDataClass.self, from: data) {
					
					DispatchQueue.main.async {
						
						self.userDeetsHere = decodedResponse
						
//						print("debuglogs Fetch worked: \(decodedResponse)")
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
