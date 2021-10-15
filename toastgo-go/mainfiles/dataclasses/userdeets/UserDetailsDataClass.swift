//
//  UserDetailsDataClass.swift
//  toastgo-go
//
//  Created by SAN on 10/14/21.
//

import Foundation
import CoreData
import SwiftUI

struct UserDetailsDataClass: Codable {
	var user: User
	var bio: String
	var image: String
	var id: Int
}

struct User: Codable {
	var user_name: String
	var phone: String
	var full_name: String
	var id: Int
	var clubs_joined_by_user: String
	var number_of_clubs_joined: Int
	var contact_list: String
	var total_frames_participation: Int
	var country_code_of_user: String
	var contact_list_sync_status: Bool
	
//	enum CodingKeys: String, CodingKey {
//		case username, phone
//		case fullName = "full_name"
//		case id
//		case clubsJoinedByUser = "clubs_joined_by_user"
//		case numberOfClubsJoined = "number_of_clubs_joined"
//		case contactList = "contact_list"
//		case totalFramesParticipation = "total_frames_participation"
//		case countryCodeOfUser = "country_code_of_user"
//		case contactListSyncStatus = "contact_list_sync_status"
//	}
}


extension UserDeets {
	
	enum Request: RawRepresentable {
		
		typealias RawValue = NSFetchRequest<UserDeets>
		
		case all
		case limited
		
		init?(rawValue: NSFetchRequest<UserDeets>) {
			return nil
		}
		
		var rawValue: NSFetchRequest<UserDeets> {
			switch self {
			
			case .all:
				let request: NSFetchRequest<UserDeets> = UserDeets.fetchRequest()
				request.sortDescriptors = []
				return request
				
			case .limited:
				let request: NSFetchRequest<UserDeets> = UserDeets.fetchRequest()
				request.sortDescriptors = []
				return request
			}
		}
	}
}

extension UserDeets {
	
//	public class func fetchRequest() -> NSFetchRequest<UserDeets> {
//
//		NSFetchRequest<UserDeets>(entityName: "UserDeets")
//	}
}

