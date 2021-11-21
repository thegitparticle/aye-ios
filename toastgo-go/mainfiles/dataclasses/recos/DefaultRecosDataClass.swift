//
//  DefaultRecosDataClass.swift
//  toastgo-go
//
//  Created by SAN on 10/17/21.
//

import Foundation

struct DefaultRecosDataClass: Codable, Equatable {
	
	var id: Int
	var links: [String]
}

struct AyeMojiDefaultRecos: Codable, Equatable {
	
	var emoji: String
	var ayemoji: String
}
