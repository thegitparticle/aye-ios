//
//  PubnubSetup.swift
//  toastgo-go
//
//  Created by SAN on 10/19/21.
//

import Foundation
import PubNub

class PubnubSetup: ObservableObject {
	
	var pubnub: PubNub
	
	init () {
		
		let config = PubNubConfiguration(
			publishKey: "pub-c-a65bb691-5b8a-4c4b-aef5-e2a26677122d",
			subscribeKey: "sub-c-d099e214-9bcf-11eb-9adf-f2e9c1644994",
			uuid: String(UserDefaults.standard.integer(forKey: "MyId"))
		)
		
		self.pubnub = PubNub(configuration: config)
		
		PubNub.log.levels = [.all]
		PubNub.log.writers = [ConsoleLogWriter(), FileLogWriter()]

	}
}
