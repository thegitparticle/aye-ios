//
//  ClanDetailsDataClass.swift
//  toastgo-go
//
//  Created by SAN on 11/27/21.
//

import Foundation

struct ClanDetailsDataClass: Codable, Equatable {
	var id: Int
	var name: String
	var member_count: Int
	var date_created: String
	var profile_picture: String
	var frames_total: Int
	var members: String
	var admin_leader: String
	var users: [ClanMember]
	var on_going_stream_status: Bool
}

struct ClanMember: Codable, Equatable {
	var user_id: Int
	var username: String
	var name: String
	var display_pic: String
}
