//
//  FramesListViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/21/21.
//

import Foundation

class FramesListViewModel: ObservableObject {
	
	@Published var framesList = [ClanFramesListItem]()
	
	public func getMyDirects(month: String, clubId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/clubs/frames_clubs_filter/2021/\(month)/\(clubId)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([ClanFramesListItem].self, from: data) {
					
					DispatchQueue.main.async {
						self.framesList = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed frames clans: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
