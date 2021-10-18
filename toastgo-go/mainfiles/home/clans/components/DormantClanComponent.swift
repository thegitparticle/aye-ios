//
//  DormantClanComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct DormantClanComponent: View {
	
	@StateObject private var viewModel = LandingScreenViewModel()
	
	var clanHere: MyClansDataClass
	
	var my_id: Int
	var my_name: String
	
//	var defaultRecosPassing: [DefaultRecosDataClass]
	
	var body: some View {
		
		NavigationLink(destination: TalkScreen(clubName: clanHere.club_name, clubId: clanHere.club_id, channelId: clanHere.pn_channel_id, ongoingFrame: clanHere.ongoing_frame, startTime: clanHere.start_time, endTime: clanHere.end_time, ongoingStream: clanHere.on_going_stream_status, ongoingStreamUser: clanHere.stream_started_by, directornot: false, my_id: my_id, my_name: my_name)) {
			
			HStack (alignment: .center) {
				
				HStack (alignment: .center) {
					
//					KFImage.url(URL(string: clanHere.club_profile_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
//						.cornerRadius(50.0)
					
					VStack(alignment: .leading) {
						
						Text(clanHere.club_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
						
						Text("tap to start new frame").foregroundColor(LightTheme.Colors.textPrimary.opacity(0.2)).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 1)
					}
					
					Spacer()
					
				}
				
			}.frame(maxWidth: .infinity).padding(.vertical, 10)
			
		}
		
	}
}

//struct DormantClanComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        DormantClanComponent()
//    }
//}
