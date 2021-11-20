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
	
}
