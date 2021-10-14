//
//  UserDetailsDataClass.swift
//  toastgo-go
//
//  Created by SAN on 10/14/21.
//

import Foundation

struct UserDetailsDataClass: Codable {
	let user: User
	let bio: String
	let image: String
	let id: Int
}

struct User: Codable {
	let username, phone, fullName: String
	let id: Int
	let clubsJoinedByUser: String
	let numberOfClubsJoined: Int
	let contactList: String
	let totalFramesParticipation: Int
	let countryCodeOfUser: String
	let contactListSyncStatus: Bool
	
	enum CodingKeys: String, CodingKey {
		case username, phone
		case fullName = "full_name"
		case id
		case clubsJoinedByUser = "clubs_joined_by_user"
		case numberOfClubsJoined = "number_of_clubs_joined"
		case contactList = "contact_list"
		case totalFramesParticipation = "total_frames_participation"
		case countryCodeOfUser = "country_code_of_user"
		case contactListSyncStatus = "contact_list_sync_status"
	}
}
