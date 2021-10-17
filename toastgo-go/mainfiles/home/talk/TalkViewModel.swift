//
//  TalkViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/16/21.
//

import Foundation

class TalkViewModel: ObservableObject {
	
	public func postStartClanFrame(club_name: Int, channel_id: String) {
		
		var payload = ["start_time": String(Int(NSDate().timeIntervalSince1970)) , "end_time": String(Int(NSDate().timeIntervalSince1970) + 43200), "club_name": club_name, "channel_id": channel_id] as [AnyHashable : Any]
		
		guard let url = URL(string: "https://apisayepirates.life/api/clubs/create_frames_clubs/") else {
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
				
				if let decodedResponse = try? JSONDecoder().decode(LoginOtpApiResponse.self, from: data) {
					
					DispatchQueue.main.async {
						
					}
				}
			}
		}.resume()
	}
	
	public func postStartDirectFrame(other_user_id: Int, channel_id: String, my_id: Int) {
		
		var payload = ["start_time": String(Int(NSDate().timeIntervalSince1970)) , "end_time": String(Int(NSDate().timeIntervalSince1970) + 43200), "users": String(other_user_id) + String(my_id), "channel_id": channel_id] as [AnyHashable : Any]
		
		guard let url = URL(string: "https://apisayepirates.life/api/clubs/create_frames_one_on_one/") else {
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
				
				if let decodedResponse = try? JSONDecoder().decode(LoginOtpApiResponse.self, from: data) {
					
					DispatchQueue.main.async {
						
					}
				}
			}
		}.resume()
	}
}
