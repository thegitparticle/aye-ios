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
	
	@Published var userDeetsHere: UserDetailsDataClass = UserDetailsDataClass(user: User(user_name: "", phone: "", full_name: "", id: 0, clubs_joined_by_user: "", number_of_clubs_joined: 0, contact_list: "", total_frames_participation: 0, country_code_of_user: "", contact_list_sync_status: false), bio: "", image: "", id: 0)
	
	@Published var userDeetsDB = [UserDeets]()
	
	@Published var clanHere = [MyClansDataClass]()
	
	@Published var liveClansHere = [MyClansDataClass] ()
	
	@Published var directsHere = [MyDirectsDataClass]()
	
	@Published var nudgeListHere = [NudgeListItemDataClass]()
	
	private var cancellable: AnyCancellable?
	
	init (userDetailsPublisher: AnyPublisher<[UserDeets], Never> = UserDeetsStore.shared.userDetails.eraseToAnyPublisher()) {
		print("debugcoredata userdetailspublisher init workng before channcellable")
		cancellable = userDetailsPublisher.sink { [unowned self] deets in
//			self.userDeetsHere.bio = deets.bio
			self.userDeetsDB = deets
		}
		print("debugcoredata userdetailspublisher init workng after channcellable")
		getUserDetails(phone: "+919849167641")
	}
	
	init () {
		getUserDetails(phone: "+919849167641")
		print("debugcoredata normal init working")
		getMyClans(userid: String(82))
		getMyDirects(userid: String(82))
		getMyNudgeList(userid: String(82))
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
		
		getUserDetails(phone: "+919849167641")
		print("debugcoredata normal init working")
		getMyClans(userid: String(82))
		getMyDirects(userid: String(82))
		getMyNudgeList(userid: String(82))
		
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
//						print("debugcoredata response before \(decodedResponse)")
						self.userDeetsHere = decodedResponse
						self.addSpaceCraft(deets: decodedResponse)
//						print("debugcoredata response \(decodedResponse)")
						print("debugcoredata \(String(describing: self.userDeetsDB))")
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
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
						print(decodedResponse)
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
}
