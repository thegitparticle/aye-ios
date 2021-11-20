//
//  PubNubTalk.swift
//  toastgo-go
//
//  Created by SAN on 10/19/21.
//

import Foundation
import PubNub

struct MetaDataCMessage: Codable, JSONCodable, Equatable {
	
	var type: String
	var user_dp: String
	
}

struct MetaDataHMessage: Codable, JSONCodable, Equatable {
	
	var type: String
	var image_url: String
	var user_dp: String
	
}

struct HOldPNMessageDataClass: Codable, JSONCodable, Equatable {

	var message: String
	var message_type: String?
	var meta: MetaDataHMessage
	var timetoken: String
	var uuid: String
}

struct FileOldMessageObject: Codable, JSONCodable, Equatable {

	let size: Int
	let mimeType, id, name: String
	
	enum CodingKeys: String, CodingKey {
		case size
		case mimeType = "mime-type"
		case id, name
	}
}

struct COldMessageObject: Codable, JSONCodable, Equatable {
	
	var message: String
	var file: FileOldMessageObject
}

struct COldPNMessageDataClass: Codable, JSONCodable, Equatable {
	
	var message: COldMessageObject
	var message_type: String?
	var meta: MetaDataCMessage
	var timetoken: String
	var uuid: String
}
