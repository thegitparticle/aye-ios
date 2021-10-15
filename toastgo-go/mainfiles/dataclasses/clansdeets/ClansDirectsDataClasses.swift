//
//  ClansDirectsDataClasses.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import Foundation

struct MyClansDataClass: Codable {
	let clubProfilePic: String
	let clubName: String
	let clubID: Int
	let pnChannelID, clubMembers: String
	let frameTotal: Int
	let ongoingFrame: Bool
	let startTime, endTime: String
	let onGoingStreamStatus: Bool
	let streamStartedBy: String
	let displayPhotos: [DisplayPhotoMyClans]
	
	enum CodingKeys: String, CodingKey {
		case clubProfilePic = "club_profile_pic"
		case clubName = "club_name"
		case clubID = "club_id"
		case pnChannelID = "pn_channel_id"
		case clubMembers = "club_members"
		case frameTotal = "frame_total"
		case ongoingFrame = "ongoing_frame"
		case startTime = "start_time"
		case endTime = "end_time"
		case onGoingStreamStatus = "on_going_stream_status"
		case streamStartedBy = "stream_started_by"
		case displayPhotos = "display_photos"
	}
}

// MARK: - DisplayPhoto
struct DisplayPhotoMyClans: Codable {
	let userID: Int
	let displayPic: String
	
	enum CodingKeys: String, CodingKey {
		case userID = "user_id"
		case displayPic = "display_pic"
	}
}


struct MyDirectsDataClass: Codable {
	let directChannelID: String
	let displayGuys: DisplayGuysMyDirects
	let frameTotal: Int
	let ongoingFrame: Bool
	let startTime, endTime: String
	let streamStatus: Bool
	let streamStartedBy: String
	
	enum CodingKeys: String, CodingKey {
		case directChannelID = "direct_channel_id"
		case displayGuys = "display_guys"
		case frameTotal = "frame_total"
		case ongoingFrame = "ongoing_frame"
		case startTime = "start_time"
		case endTime = "end_time"
		case streamStatus = "stream_status"
		case streamStartedBy = "stream_started_by"
	}
}

// MARK: - DisplayGuys
struct DisplayGuysMyDirects: Codable {
	let userID: String
	let profilePicture: String
	let fullName: String
	
	enum CodingKeys: String, CodingKey {
		case userID = "user_id"
		case profilePicture = "profile_picture"
		case fullName = "full_name"
	}
}
