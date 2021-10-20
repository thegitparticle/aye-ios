//
//  CamStreamViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/20/21.
//

import Foundation

class CamStreamViewModel: ObservableObject {
	
	public func startStreamClubServerCalls(channelId: String, clubId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/agora_start_composite_recording/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(channelId)") else {
			
			return
		}
		
		guard let url2 = URL(string: "https://apisayepirates.life/api/users/start_club_stream/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(clubId)") else {
			
			return
		}
		
		let request = URLRequest(url: url)
		let request2 = URLRequest(url: url2)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				
				print("debuguserdefs Fetch failed user deets: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
		
		URLSession.shared.dataTask(with: request2) {data, response, error in
		
		}.resume()
	
	}
	
	public func stopStreamClubServerCalls(channelId: String, clubId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/stop_club_stream/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(clubId)") else {
			
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				
				print("debuguserdefs Fetch failed user deets: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
		
	}
	
	public func startStreamDirectServerCalls(channelId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/agora_start_composite_recording/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(channelId)") else {
			
			return
		}
		
		guard let url2 = URL(string: "https://apisayepirates.life/api/users/start_direct_stream/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(channelId)") else {
			
			return
		}
		
		let request = URLRequest(url: url)
		let request2 = URLRequest(url: url2)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				
				print("debuguserdefs Fetch failed user deets: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
		
		URLSession.shared.dataTask(with: request2) {data, response, error in
			
		}.resume()
		
	}
	
	public func stopStreamDirectServerCalls(channelId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/stop_direct_stream/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(channelId)") else {
			
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				
				print("debuguserdefs Fetch failed user deets: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
		
	}
	
	@Published var agoraToken: String = ""
	
	public func getAgoraToken(channelId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/agora_token_generator/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(channelId)") else {
			
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(String.self, from: data) {
					
					DispatchQueue.main.async {
						self.agoraToken = decodedResponse
					}
					return
				}
				
				print("debuguserdefs Fetch failed user deets: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
}
