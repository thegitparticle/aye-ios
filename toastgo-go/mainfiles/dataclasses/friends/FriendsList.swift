//
//  FriendsList.swift
//  toastgo-go
//
//  Created by SAN on 11/20/21.
//

import Foundation

struct FriendsListItemDataClass: Codable, Equatable, Hashable {
	
	var name: String
	var friend_user_id: Int
	var profile_pic: String
}
