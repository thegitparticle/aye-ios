//
//  EnterPhoneViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/13/21.
//

import Foundation
import Combine
import SwiftUI

struct PhoneCheckApiResponse: Codable {
	var user_exists: String
}

class EnterPhoneViewModel: ObservableObject {
	
	@Published var phoneCheck: String = ""
	
	public func checkPhoneNumber(phone: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/send_otp/\(phone)") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(PhoneCheckApiResponse.self, from: data) {
					
					DispatchQueue.main.async {
						self.phoneCheck = decodedResponse.user_exists
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
