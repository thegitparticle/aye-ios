//
//  OtherProfileViewModel.swift
//  toastgo-go
//
//  Created by SAN on 11/28/21.
//

import Foundation

// https://apisayepirates.life/api/users/profile-update/?id=&user=82

class OtherProfileViewModel: ObservableObject {

	@Published var otherProfileDeetsHere: OtherUserDetailsDataClass = OtherUserDetailsDataClass(user: OtherUserHere(username: "", phone: "", full_name: "", id: 0, clubs_joined_by_user: "", number_of_clubs_joined: 0, contact_list: "", total_frames_participation: 0, country_code_of_user: "", contact_list_sync_status: false), bio: "", image: "", id: 0)

	public func getOtherProfileDetailsHere(otherprofileid: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/profile/profile-update/?id=&user=\(otherprofileid)") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(OtherUserDetailsDataClass.self, from: data) {
					
					DispatchQueue.main.async {
						self.otherProfileDeetsHere = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}

}
