//
//  FramesListItems.swift
//  toastgo-go
//
//  Created by SAN on 10/21/21.
//

import Foundation

struct ClanFramesListItem: Codable, Equatable {
	
	var id: Int
	var club_name: Int
	var published_date: String
	var frame_picture: String?
	var start_time: String
	var end_time: String
	var channel_id: String
	var frame_picture_link: String
	var frame_status: Bool
	
}


struct DirectFramesListItem: Codable, Equatable {
	
	var id: Int
	var users: String
	var published_date: String
	var frame_picture: String?
	var start_time: String
	var end_time: String
	var channel_id: String
	var frame_picture_link: String
	var frame_status: Bool
	
}
