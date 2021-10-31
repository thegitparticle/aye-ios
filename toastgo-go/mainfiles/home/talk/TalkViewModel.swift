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
	
	@Published var customRecos = [DefaultRecosDataClass]()
	
	@Published var oldMessagesReceived = [PubNubMessage]()
	
	@Published var newMessagesReceived = [PubNubMessage]()
	
	@Published var otherUserDetailsHere = [OtherUserDetailsDataClass]()
	
//	@Published var otherUserDetailsHere = [OtherUserDetailsDataClass(user: OtherUserHere(username: "", phone: "", full_name: 0, id: false, clubs_joined_by_user: 0, number_of_clubs_joined: "", contact_list: "", total_frames_participation: "", country_code_of_user: 0, contact_list_sync_status: ""), bio: "", image: "", id: 0)]
	
	@Published var agoraToken: String = ""
	
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

		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([DefaultRecosDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
						self.defaultRecos = decodedResponse
						
					}
					return
				}
				
				print("debugtextinput Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func sendPubnubHMessage (message: String, selectedReco: String, channelId: String, pubnubConfig: PubnubSetup) {
		
//		let config = PubNubConfiguration(
//			publishKey: "pub-c-a65bb691-5b8a-4c4b-aef5-e2a26677122d",
//			subscribeKey: "sub-c-d099e214-9bcf-11eb-9adf-f2e9c1644994",
//			uuid: String(UserDefaults.standard.integer(forKey: "MyId"))
//		)
//
//		let pubnub = PubNub(configuration: config)
		
		let metaHere = MetaDataHMessage(type: "h", image_url: selectedReco ,user_dp: UserDefaults.standard.string(forKey: "MyDp") ?? "")
		
		pubnubConfig.pubnub.publish(channel: channelId, message: message, shouldStore: true, meta: metaHere) { result in
			
			switch result {
			
				case let .success(timetoken):
					
					print("Message Successfully Published at: \(timetoken)")
					
				case let .failure(error):
					
					print("Failed Response: \(error.localizedDescription)")
				
			}
		}
	}
	
	public func getOldMessagesFromPn (channelId: String, start: Int, end: Int, pubnubConfig: PubnubSetup) {
		
		print("pubnubmessagesgrabdebug", "get old messages called - after config ")
		
		pubnubConfig.pubnub.fetchMessageHistory(for: [channelId], includeMeta: true, page: PubNubBoundedPageBase(start: Timetoken(start), end: Timetoken(end))) { result in
			
			switch result {
			case let .success(response):
				print(response)
				if let myChannelMessages = response.messagesByChannel[channelId] {
					
					self.oldMessagesReceived = myChannelMessages

					
				}
				if let nextPage = response.next {
					print("The next page used for pagination: \(nextPage)")
				}
			case let .failure(error):
				print("pubnubmessagesgrabdebug", "Failed History Fetch Response: \(error.localizedDescription)")
			}
		}
	}
	
	
	public func subscribeToPnChannel (channelId: String, pubnubConfig: PubnubSetup) {

		pubnubConfig.pubnub.subscribe(to: [channelId])

		let listener = SubscriptionListener()
		
		listener.didReceiveSubscription = { event in
			switch event {
			case let .messageReceived(message):
				
				self.newMessagesReceived.append(message)
				
				print("\(message)")
			case let .connectionStatusChanged(status):
				print("Status Received: \(status)")
			case let .presenceChanged(presence):
				print("Presence Received: \(presence)")
			case let .subscribeError(error):
				print("Subscription Error \(error)")
			default:
				break
			}
		}
		
		// Start receiving subscription events
		pubnubConfig.pubnub.add(listener)

	}
	
	public func getOtherUserDetails (otheruserid: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/profile-update/?id=&user=\(otheruserid)") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([OtherUserDetailsDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						self.otherUserDetailsHere = decodedResponse
					}
					return
				}
				
				print("debuguserdefs Fetch failed user deets: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getAgoraToken(channelId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/agora_token_generator/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(channelId)/") else {
			
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

	public func getCustomRecosTalkVM (userid: String, word: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/recommend_images/\(userid)/\(word)/False/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([DefaultRecosDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
						self.customRecos = decodedResponse
						
					}
					return
				}
				
				print("debugtextinput Fetch failed custom recos: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
}
