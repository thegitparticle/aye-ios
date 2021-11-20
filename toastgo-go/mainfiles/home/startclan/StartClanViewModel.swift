//
//  StartClanViewModel.swift
//  toastgo-go
//
//  Created by SAN on 11/20/21.
//

import Foundation

class StartClanViewModel: ObservableObject {
	
	@Published var friendsList = [FriendsListItemDataClass]()
	@Published var contactsList = [ContactsListItemDataClass]()
	
	@Published var newClanDetailsFromServer = StartClanResponseDataClass(id: 0, name: "", members: "", admin_leader: 0, pn_channel_id: "")
	
	@Published var clanSetUpStatus = false
	
	init () {
		
		getFriendsListHere()
		getContactsListHere()
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
				
				print("debuglogs Fetch failed friends list: \(error?.localizedDescription ?? "Unknown error")")
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
	
	public func postStartNewClan(clan_name: String, friendsList: [Int], contactsList: [String]) {
		
		var payload = ["name": clan_name , "members": String(UserDefaults.standard.integer(forKey: "MyId")), "admin_leader": UserDefaults.standard.integer(forKey: "MyId")] as [AnyHashable : Any]
		
		guard let url = URL(string: "https://apisayepirates.life/api/clubs/create_club/") else {
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
				
				if let decodedResponse = try? JSONDecoder().decode(StartClanResponseDataClass.self, from: data) {
					
					DispatchQueue.main.async {
						
						self.newClanDetailsFromServer = decodedResponse
						
						let club_id_gotten = decodedResponse.id
						
						for item in friendsList {
							
							self.getAddFriendsToClan(added_user: item, clan_id: club_id_gotten)
						}
						
						for item2 in contactsList {
							
							self.getInviteContactsToClan(invited_phone: item2, clan_id: club_id_gotten)
						}
						
						self.clanSetUpStatus = true
					}
				}
			}
		}.resume()
	}
	
	public func getAddFriendsToClan(added_user: Int, clan_id: Int) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/add_users_to_club/\(String(added_user))/\(String(clan_id))/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				
				if let decodedResponse = try? JSONDecoder().decode([ContactsListItemDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
					}
					
					return
				}
				
//				print("debuglogs Fetch failed contacts list: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getInviteContactsToClan(invited_phone: String, clan_id: Int) {
		
		let userid = UserDefaults.standard.integer(forKey: "MyId")
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/send_invite/\(invited_phone)/\(String(userid))/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				
				if let decodedResponse = try? JSONDecoder().decode([ContactsListItemDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
					}
					
					return
				}
				
				//				print("debuglogs Fetch failed contacts list: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
		
		guard let url2 = URL(string: "https://apisayepirates.life/api/users/add_invited_user/\(invited_phone)/\(String(userid))/\(String(clan_id))/") else {
			return
		}
		
		let request2 = URLRequest(url: url2)
		
		URLSession.shared.dataTask(with: request2) { data, response, error in
			
			if let data = data {
				
				if let decodedResponse = try? JSONDecoder().decode([ContactsListItemDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
					}
					
					return
				}
				
				//				print("debuglogs Fetch failed contacts list: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
}
