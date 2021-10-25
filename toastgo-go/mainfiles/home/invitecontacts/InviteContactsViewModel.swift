//
//  InviteContactsViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/25/21.
//

import Foundation

class InviteContactsViewModel: ObservableObject {
	
	@Published var contactsList = [ContactsListItemDataClass]()
	
	init () {
		
		getContactsListHere()
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
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
}
