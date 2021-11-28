//
//  FramesListViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/21/21.
//

import Foundation

class FramesListViewModel: ObservableObject {
	
	@Published var framesList = [ClanFramesListItem]()
	
	@Published var framesListDirects = [DirectFramesListItem]()
	
	public func getClubFramesPerMonth(month: String, clubId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/clubs/frames_clubs_filter/2021/\(month)/\(clubId)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([ClanFramesListItem].self, from: data) {
					
					DispatchQueue.main.async {
						self.framesList = decodedResponse
						print("framepicdebug - frames grabbing worked")
					}
					return
				}
				
				print("framepicdebug debuglogs Fetch failed frames clans: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getDirectFramesPerMonth(month: String, channelId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/clubs/frames_one_on_one_filtered/2021/\(month)/\(channelId)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([DirectFramesListItem].self, from: data) {
					
					DispatchQueue.main.async {
						self.framesListDirects = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed frames directs: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
