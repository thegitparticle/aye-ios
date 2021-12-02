//
//  TheAyeViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/25/21.
//

import Foundation
import SwiftUI

class TheAyeViewModel: ObservableObject {
	
	public func getStartDirectChannel(otheruserid: String) {
		
		let myuserid = String(UserDefaults.standard.integer(forKey: "MyId"))
		
		let directid = myuserid + "_" + otheruserid + "_d"
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/start_chat/\(myuserid)/\(otheruserid)/\(directid)") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let response = response {

				print(response)
			}
			
			print("debuglogs Fetch failed nudge list: \(error?.localizedDescription ?? "Unknown error")")
			
		}.resume()
	}
}
