//
//  LandingScreenViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import Foundation
import Combine
import SwiftUI

class LandingScreenViewModel: ObservableObject {
	
	@Published var userDeetsHere = UserDetailsDataClass(bio: "", id: 0, image: "", user: User(phone: "", number_of_clubs_joined: 0, contact_list_sync_status: false, id: 0, country_code_of_user: "", username: "", clubs_joined_by_user: "", full_name: "", total_frames_participation: 0, contact_list: ""))
	
	
	@Published var userDeetsDB = [UserDeets]()
	
	@Published var clanHere = [MyClansDataClass]()
	
	@Published var liveClansHere = [MyClansDataClass] ()
	
	@Published var directsHere = [MyDirectsDataClass]()
	
	@Published var nudgeListHere = [NudgeListItemDataClass]()
	
	@Published var defaultRecos = [DefaultRecosDataClass]()
	
	private var cancellable: AnyCancellable?
	
	init (userDetailsPublisher: AnyPublisher<[UserDeets], Never> = UserDeetsStore.shared.userDetails.eraseToAnyPublisher()) {
		print("debugcoredata userdetailspublisher init workng before channcellable")
		cancellable = userDetailsPublisher.sink { [unowned self] deets in
			self.userDeetsDB = deets
		}
		print("debugcoredata userdetailspublisher init workng after channcellable")
		getUserDetails(phone: "+919849167641")
	}
	
	init () {

		getUserDetails(phone: UserDefaults.standard.string(forKey: "MyPhone") ?? "")
		getMyClans(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
		getMyDirects(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
		getMyNudgeList(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
//		getDefaultRecos(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
	}
	
	func addSpaceCraft(deets: UserDetailsDataClass) {
		print("debugcoredata add spacecraft called func")
		UserDeetsStore.shared.add(id: deets.id, image: deets.image, bio: deets.bio, user: String(9))
		print("debugcoredata add spacecraft called func ended workijng")
	}
	
	func deleteCourse(deets: UserDetailsDataClass) {
		
		UserDeetsStore.shared.delete(id: deets.id)
	}
	
	public func refreshLandingViewModel () {
		
		getMyClans(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
		getMyDirects(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
		getMyNudgeList(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
		getDefaultRecos(userid: String(UserDefaults.standard.integer(forKey: "MyId")))
		
	}
	
	public func getUserDetails(phone: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/profile/\(phone)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(UserDetailsDataClass.self, from: data) {
					
					DispatchQueue.main.async {
						self.userDeetsHere = decodedResponse
					}
					return
				}
				
				print("debuguserdefs Fetch failed user deets: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getMyClans(userid: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/my_clubs/\(userid)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([MyClansDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						
						self.liveClansHere = []
						self.clanHere = []
						
						for item in decodedResponse {

							if (item.ongoing_frame) {

								self.liveClansHere.append(item)
							} else {

								self.clanHere.append(item)
							}
						}
//						self.clanHere = decodedResponse
//						print(decodedResponse)
					}
					return
				}
				
				print("debuglogs Fetch failed calns: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getMyDirects(userid: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/my_directs/\(userid)") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([MyDirectsDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						self.directsHere = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed directs: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getMyNudgeList(userid: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/friends_but_not_friends/\(userid)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode([NudgeListItemDataClass].self, from: data) {
					
					DispatchQueue.main.async {
						self.nudgeListHere = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed nudge list: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func getDefaultRecos (userid: String) {

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

//						print("debugtextinput \(String(describing: self.defaultRecos))")
					}
					return
				}

				print("debugtextinput Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}

		}.resume()
	}
	
	public func getStartDirectChannel(otheruserid: String) {
		
		let myuserid = String(UserDefaults.standard.integer(forKey: "MyId"))
		
		let directid = myuserid + "_" + otheruserid + "_d"
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/start_chat/\(myuserid)/\(otheruserid)/\(directid)") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let response = response {
				
				self.refreshLandingViewModel()
				print(response)
			}
				
				print("debuglogs Fetch failed nudge list: \(error?.localizedDescription ?? "Unknown error")")
			
		}.resume()
	}
}
