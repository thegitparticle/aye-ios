//
//  CheckInvitedOrNotViewModel.swift
//  toastgo-go
//
//  Created by SAN on 12/3/21.
//

import Foundation

struct CheckInvitedOrNotApiResponse: Codable {
	
	var invited_to_clubs_id: String
	var invited_to_clubs_name: String
	var invited_by_user: String
}

class CheckInvitedOrNotViewModel: ObservableObject {
	
	@Published var invitedOrNotStatus: String = ""

	public func getCheckInvitedOrNotApi(phone: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/invited_or_not_api/\(phone)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(CheckInvitedOrNotApiResponse.self, from: data) {
					
					DispatchQueue.main.async {
						
						self.invitedOrNotStatus = decodedResponse.invited_by_user
						
					}
					
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
