//
//  PubNubTalk.swift
//  toastgo-go
//
//  Created by SAN on 10/19/21.
//

import Foundation
import PubNub

struct MetaDataCMessage: Codable, JSONCodable {
	
	var type: String
	var user_dp: String
	
}

struct MetaDataHMessage: Codable, JSONCodable {
	
	var type: String
	var image_url: String
	var user_dp: String
	
}
