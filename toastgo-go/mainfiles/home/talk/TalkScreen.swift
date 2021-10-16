//
//  TalkScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/16/21.
//

import SwiftUI

struct TalkScreen: View {
	
	var clubName: String
	var clubId: Int
	var channelId: String
	var ongoingFrame: Bool
	var startTime: String
	var endTime: String
	var ongoingStream: Bool
	var ongoingStreamUser: String
	var directornot: Bool
	
	
    var body: some View {
		
		Text(clubName).foregroundColor(LightTheme.Colors.textSecondary).font(LightTheme.Typography.h4).padding(20)
    }
	
}

struct TalkScreen_Previews: PreviewProvider {
    static var previews: some View {
		TalkScreen(clubName: "", clubId: 0, channelId: "", ongoingFrame: false, startTime: "", endTime: "", ongoingStream: false, ongoingStreamUser: "", directornot: false)
    }
}
