//
//  MyProfileViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import Foundation

class MyProfileViewModel: ObservableObject {
	
	@Published var userDeetsHere: UserDetailsDataClass = UserDetailsDataClass(bio: "", id: 0, image: "", user: User(phone: "", number_of_clubs_joined: 0, contact_list_sync_status: false, id: 0, country_code_of_user: "", username: "", clubs_joined_by_user: "", full_name: "", total_frames_participation: 0, contact_list: ""))
	
	init () {
		
		getUserDetailsHere()
	}
	
	public func getUserDetailsHere() {
		
		let phone = UserDefaults.standard.string(forKey: "MyPhone") ?? ""
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/profile/\(phone)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(UserDetailsDataClass.self, from: data) {
					
					DispatchQueue.main.async {
						self.userDeetsHere = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
}
