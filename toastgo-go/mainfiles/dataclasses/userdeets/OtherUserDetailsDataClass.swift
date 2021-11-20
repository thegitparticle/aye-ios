//
//  OtherUserDetailsDataClass.swift
//  toastgo-go
//
//  Created by SAN on 10/26/21.
//

import Foundation

struct OtherUserDetailsDataClass: Codable, Equatable {
	
	var user: OtherUserHere
	var bio: String
	var image: String
	var id: Int
}

struct OtherUserHere: Codable, Equatable {
	
	var username: String
	var phone: String
	var full_name: String
	var id: Int
	var clubs_joined_by_user: String
	var number_of_clubs_joined: Int
	var contact_list: String
	var total_frames_participation: Int
	var country_code_of_user: String
	var contact_list_sync_status: Bool
}
