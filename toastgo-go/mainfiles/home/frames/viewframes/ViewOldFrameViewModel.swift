//
//  ViewOldFrameViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/23/21.
//

import Foundation
import PubNub

class ViewOldFrameViewModel: ObservableObject {
	
	@Published var messagesOfThisFrame = [PubNubMessage]()
	
	public func getOldMessagesOfThisFrameFromPn (channelId: String, start: Int, end: Int, pubnubConfig: PubnubSetup) {
		
		print("pubnubmessagesgrabdebug", "get old messages called - after config ")
		
		pubnubConfig.pubnub.fetchMessageHistory(for: [channelId], includeMeta: true, page: PubNubBoundedPageBase(start: Timetoken(start), end: Timetoken(end))) { result in
			
			switch result {
			case let .success(response):
				print(response)
				if let myChannelMessages = response.messagesByChannel[channelId] {
					
					self.messagesOfThisFrame = myChannelMessages
					
					
				}
				if let nextPage = response.next {
					print("The next page used for pagination: \(nextPage)")
				}
			case let .failure(error):
				print("pubnubmessagesgrabdebug", "Failed History Fetch Response: \(error.localizedDescription)")
			}
		}
	}
	
}
