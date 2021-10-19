//
//  TalkViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/16/21.
//

import Foundation
import PubNub

class TalkViewModel: ObservableObject {
	
	@Published var defaultRecos = [DefaultRecosDataClass]()
	
	init () {
		
		getDefaultRecosTalkVM(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
	}
	
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
	
	public func getDefaultRecosTalkVM (userid: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/recommend_images/82/fun/False/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		print("debugtextinput get def recos func is called")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([DefaultRecosDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
						self.defaultRecos = decodedResponse
						
						print("debugtextinput \(String(describing: self.defaultRecos))")
					}
					return
				}
				
				print("debugtextinput Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func sendPubnubHMessage (message: String, selectedReco: String, channelId: String) {
		
		let config = PubNubConfiguration(
			publishKey: "pub-c-a65bb691-5b8a-4c4b-aef5-e2a26677122d",
			subscribeKey: "sub-c-d099e214-9bcf-11eb-9adf-f2e9c1644994",
			uuid: String(UserDefaults.standard.integer(forKey: "MyId"))
		)
		
		let pubnub = PubNub(configuration: config)
		
		let metaHere = MetaDataHMessage(type: "h", image_url: selectedReco ,user_dp: UserDefaults.standard.string(forKey: "MyDp") ?? "")
		
		pubnub.publish(channel: channelId, message: message, shouldStore: true, meta: metaHere) { result in
			
			switch result {
			
				case let .success(timetoken):
					
					print("Message Successfully Published at: \(timetoken)")
					
				case let .failure(error):
					
					print("Failed Response: \(error.localizedDescription)")
				
			}
		}
	}
	
}
