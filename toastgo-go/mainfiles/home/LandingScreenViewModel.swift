//
//  LandingScreenViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import Foundation


class LandingScreenViewModel: ObservableObject {
	
	@Published var userDeetsHere: UserDetailsDataClass = UserDetailsDataClass(user: User(username: "", phone: "", fullName: "", id: 0, clubsJoinedByUser: "", numberOfClubsJoined: 0, contactList: "", totalFramesParticipation: 0, countryCodeOfUser: "", contactListSyncStatus: false), bio: "", image: "", id: 0)
	
	@Published var clanHere: [MyClansDataClass] = []
	
	@Published var directsHere: [MyDirectsDataClass] = []
	
	init () {
		getUserDetails(phone: "+919849167641")
		getMyClans(userid: String(userDeetsHere.user.id))
		getMyDirects(userid: String(userDeetsHere.user.id))
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
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getMyClans(userid: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/my_clubs/\(userid)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([MyClansDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						self.clanHere = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getMyDirects(userid: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/my_directs/\(userid)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([MyDirectsDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						self.directsHere = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
