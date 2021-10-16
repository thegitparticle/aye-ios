//
//  ClansDirectsDataClasses.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import Foundation

struct MyClansDataClass: Codable, Equatable {
	var club_profile_pic: String
	var club_name: String
	var club_id: Int
	var pn_channel_id: String
	var club_members: String
	var frame_total: Int
	var ongoing_frame: Bool
	var start_time: String
	var end_time: String
	var on_going_stream_status: Bool
	var stream_started_by: String
	var display_photos: [DisplayPhotoMyClans]
	
//	enum CodingKeys: String, CodingKey {
//		case clubProfilePic = "club_profile_pic"
//		case clubName = "club_name"
//		case clubID = "club_id"
//		case pnChannelID = "pn_channel_id"
//		case clubMembers = "club_members"
//		case frameTotal = "frame_total"
//		case ongoingFrame = "ongoing_frame"
//		case startTime = "start_time"
//		case endTime = "end_time"
//		case onGoingStreamStatus = "on_going_stream_status"
//		case streamStartedBy = "stream_started_by"
//		case displayPhotos = "display_photos"
//	}
}

// MARK: - DisplayPhoto
struct DisplayPhotoMyClans: Codable, Equatable {
	
	var user_id: Int
	var display_pic: String
	
}


struct MyDirectsDataClass: Codable, Equatable {
	var direct_channel_id: String
	var display_guys: DisplayGuysMyDirects
	var frame_total: Int
	var ongoing_frame: Bool
	var start_time: String
	var end_time: String
	var stream_status: Bool
	var stream_started_by: String
	
//	enum CodingKeys: String, CodingKey {
//		case directChannelID = "direct_channel_id"
//		case displayGuys = "display_guys"
//		case frameTotal = "frame_total"
//		case ongoingFrame = "ongoing_frame"
//		case startTime = "start_time"
//		case endTime = "end_time"
//		case streamStatus = "stream_status"
//		case streamStartedBy = "stream_started_by"
//	}
}

// MARK: - DisplayGuys
struct DisplayGuysMyDirects: Codable, Equatable {
	let user_id: String
	let profile_picture: String
	let full_name: String
	
//	enum CodingKeys: String, CodingKey {
//		case userID = "user_id"
//		case profilePicture = "user_id"
//		case fullName = "full_name"
//	}
}

// MARK: - Nudge List Item

struct NudgeListItemDataClass: Codable, Equatable {
	
	var name: String
	var id: Int
	var profile_pic: String
}
