//
//  UserDetailsDataClass.swift
//  toastgo-go
//
//  Created by SAN on 10/14/21.
//

import Foundation
import CoreData
import SwiftUI

struct UserDetailsDataClass: Codable, Equatable {
	var bio: String
	var id: Int
	var image: String
	var user: User
}

struct User: Codable, Equatable {
	var phone: String
	var number_of_clubs_joined: Int
	var contact_list_sync_status: Bool
	var id: Int
	var country_code_of_user: String
	var username: String
	var clubs_joined_by_user: String
	var full_name: String
	var total_frames_participation: Int
	var contact_list: String
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

