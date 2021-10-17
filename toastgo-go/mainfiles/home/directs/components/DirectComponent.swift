//
//  DirectComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct DirectComponent: View {
	
	var directHere: MyDirectsDataClass
	
	var my_id: Int
	var my_name: String
	
	var body: some View {
		
		NavigationLink(destination: TalkScreen(clubName: directHere.display_guys.full_name, clubId: Int(directHere.display_guys.user_id) ?? 0, channelId: directHere.direct_channel_id, ongoingFrame: directHere.ongoing_frame, startTime: directHere.start_time, endTime: directHere.end_time, ongoingStream: directHere.stream_status, ongoingStreamUser: directHere.stream_started_by, directornot: true, my_id: my_id, my_name: my_name)) {
		
		HStack (alignment: .center) {
			
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: directHere.display_guys.profile_picture)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0)
				
				
				VStack(alignment: .leading) {
					
					Text(directHere.display_guys.full_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
					
					Text("tap and start new frame").foregroundColor(LightTheme.Colors.textPrimary.opacity(0.2)).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 1)
				}
				
				Spacer()
			}
			
		}.frame(maxWidth: .infinity).padding(.vertical, 10)
			
		}
		
	}
}

//struct DirectComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectComponent()
//    }
//}
