//
//  StartClanDataClasses.swift
//  toastgo-go
//
//  Created by SAN on 11/20/21.
//

import Foundation

struct StartClanDataClass: Codable, Equatable, Hashable {
	
	var name: String
	var members: String
	var admin_leader: Int
}


struct StartClanResponseDataClass: Codable, Equatable, Hashable {
	
	var id: Int
	var name: String
	var members: String
	var admin_leader: Int
	var pn_channel_id: String
}
