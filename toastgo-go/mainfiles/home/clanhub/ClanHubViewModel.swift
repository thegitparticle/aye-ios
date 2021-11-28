//
//  ClanHubViewModel.swift
//  toastgo-go
//
//  Created by SAN on 11/27/21.
//

import Foundation

class ClanHubViewModel: ObservableObject {
	
	@Published var clanDetails = ClanDetailsDataClass(id: 0, name: "", member_count: 0, date_created: "", profile_picture: "", frames_total: 0, members: "", admin_leader: "", users: [], on_going_stream_status: false)
	
	@Published var contactsList = [ContactsListItemDataClass]()
	
	@Published var friendsList = [FriendsListItemDataClass]()
	
	init () {
		
		getContactsListHere()
		getFriendsListHere()
	}
	
	public func getClanDetails(clubId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/clubs/\(clubId)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(ClanDetailsDataClass.self, from: data) {
					
					DispatchQueue.main.async {
						self.clanDetails = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed frames clans: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getContactsListHere() {
		
		let userid = UserDefaults.standard.integer(forKey: "MyId")
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/user_separate_contact_list/\(userid)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([ContactsListItemDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
						self.contactsList = decodedResponse
					}
					
					return
				}
				
				print("debuglogs Fetch failed contacts list: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getFriendsListHere() {
		
		let userid = UserDefaults.standard.integer(forKey: "MyId")
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/fetch_friends_list/\(userid)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([FriendsListItemDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
						self.friendsList = decodedResponse
					}
					
					return
				}
				
				print("debuglogs Fetch failed contacts list: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
}
