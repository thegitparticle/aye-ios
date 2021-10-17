//
//  LiveClanComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct LiveClanComponent: View {
	
	var clanHere: MyClansDataClass
	
	var my_id: Int
	var my_name: String
	
	var indexInList: Int
	
	var defaultRecosPassing: [DefaultRecosDataClass]
	
	var body: some View {
		
		if (clanHere.display_photos.count == 1) {
			NavigationLink(destination: TalkScreen(clubName: clanHere.club_name, clubId: clanHere.club_id, channelId: clanHere.pn_channel_id, ongoingFrame: clanHere.ongoing_frame, startTime: clanHere.start_time, endTime: clanHere.end_time, ongoingStream: clanHere.on_going_stream_status, ongoingStreamUser: clanHere.stream_started_by, directornot: false,  my_id: my_id, my_name: my_name, defaultRecosPassing: defaultRecosPassing)) {
				HStack () {
					
					if (indexInList/2 == 0) {
						
						OneOtherPerson(liveClanHere: clanHere)
						
						Spacer()
					} else {
						
						Spacer()
						
						OneOtherPerson(liveClanHere: clanHere)
					}
					
				}.frame(maxWidth: .infinity).padding(20)
				
			}
			
		} else if (clanHere.display_photos.count == 2) {
			
			NavigationLink(destination: TalkScreen(clubName: clanHere.club_name, clubId: clanHere.club_id, channelId: clanHere.pn_channel_id, ongoingFrame: clanHere.ongoing_frame, startTime: clanHere.start_time, endTime: clanHere.end_time, ongoingStream: clanHere.on_going_stream_status, ongoingStreamUser: clanHere.stream_started_by, directornot: false, my_id: my_id, my_name: my_name, defaultRecosPassing: defaultRecosPassing)) {
				
				HStack () {
					
					if (indexInList/2 == 0) {
						
						TwoOtherPeople(liveClanHere: clanHere)
						
						Spacer()
					} else {
						
						Spacer()
						
						TwoOtherPeople(liveClanHere: clanHere)
					}
					
				}.frame(maxWidth: .infinity).padding(20)
				
			}
			
		} else if (clanHere.display_photos.count == 3) {
			
			NavigationLink(destination: TalkScreen(clubName: clanHere.club_name, clubId: clanHere.club_id, channelId: clanHere.pn_channel_id, ongoingFrame: clanHere.ongoing_frame, startTime: clanHere.start_time, endTime: clanHere.end_time, ongoingStream: clanHere.on_going_stream_status, ongoingStreamUser: clanHere.stream_started_by, directornot: false,  my_id: my_id, my_name: my_name, defaultRecosPassing: defaultRecosPassing)) {
				
				HStack () {
					
					if (indexInList/2 == 0) {
						
						ThreeOtherPeople(liveClanHere: clanHere)
						
						Spacer()
					} else {
						
						Spacer()
						
						ThreeOtherPeople(liveClanHere: clanHere)
					}
					
					
				}.frame(maxWidth: .infinity).padding(20)
				
			}
			
		} else if (clanHere.display_photos.count > 3) {
			
			NavigationLink(destination: TalkScreen(clubName: clanHere.club_name, clubId: clanHere.club_id, channelId: clanHere.pn_channel_id, ongoingFrame: clanHere.ongoing_frame, startTime: clanHere.start_time, endTime: clanHere.end_time, ongoingStream: clanHere.on_going_stream_status, ongoingStreamUser: clanHere.stream_started_by, directornot: false,  my_id: my_id, my_name: my_name, defaultRecosPassing: defaultRecosPassing)) {
				
				HStack () {
					
					if (indexInList/2 == 0) {
						
						MoreOtherPeople(liveClanHere: clanHere)
						
						Spacer()
					} else {
						
						Spacer()
						
						MoreOtherPeople(liveClanHere: clanHere)
					}
					
				}.frame(maxWidth: .infinity).padding(20)
				
			}
			
		} else {
			
			NavigationLink(destination: TalkScreen(clubName: clanHere.club_name, clubId: clanHere.club_id, channelId: clanHere.pn_channel_id, ongoingFrame: clanHere.ongoing_frame, startTime: clanHere.start_time, endTime: clanHere.end_time, ongoingStream: clanHere.on_going_stream_status, ongoingStreamUser: clanHere.stream_started_by, directornot: false,  my_id: my_id, my_name: my_name, defaultRecosPassing: defaultRecosPassing)) {
				
				HStack () {
					
					if (indexInList/2 == 0) {
						
						OneOtherPerson(liveClanHere: clanHere)
						
						Spacer()
					} else {
						
						Spacer()
						
						OneOtherPerson(liveClanHere: clanHere)
					}
					
				}.frame(maxWidth: .infinity).padding(20)
				
			}
		}
		
	}
}

private struct OneOtherPerson: View {
	
	var liveClanHere: MyClansDataClass
	
	var body: some View {
		VStack() {
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: liveClanHere.display_photos[0].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0)
				
			}
			
			TextPart()
		}
	}
}

private struct TwoOtherPeople: View {
	
	var liveClanHere: MyClansDataClass
	
	var body: some View {
		VStack() {
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: liveClanHere.display_photos[0].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0).offset(x: +5)
				
				KFImage.url(URL(string: liveClanHere.display_photos[1].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0).offset(x: -5)
				
			}
			
			TextPart()
		}
	}
}

private struct ThreeOtherPeople: View {
	
	var liveClanHere: MyClansDataClass
	
	var body: some View {
		
		VStack () {
			
			KFImage.url(URL(string: liveClanHere.display_photos[0].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
				.cornerRadius(50.0).offset(y: +10)
			
			
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: liveClanHere.display_photos[1].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0).offset(x: +5)
				
				KFImage.url(URL(string: liveClanHere.display_photos[2].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0).offset(x: -5)
			}.offset(y: -10)
			
			TextPart()
			
		}
	}
}

private struct MoreOtherPeople: View {
	
	var liveClanHere: MyClansDataClass
	
	var body: some View {
		
		VStack () {
			
			KFImage.url(URL(string: liveClanHere.display_photos[0].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
				.cornerRadius(50.0).offset(y: +10)
			
			
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: liveClanHere.display_photos[1].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0).offset(x: +5)
				
				KFImage.url(URL(string: liveClanHere.display_photos[2].display_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0).offset(x: -5)
				
			}.offset(y: -10)
			
			ZStack {
				
				Circle().frame(width: 30, height: 30)
					.padding()
					.foregroundColor(LightTheme.Colors.textSecondary)
					.background(LightTheme.Colors.textSecondary)
					.cornerRadius(70)
				
				Text("+3").foregroundColor(LightTheme.Colors.uiSurface).font(LightTheme.Typography.subtitle1)
				
			}.offset(y: -25)
			
			TextPart()
			
		}
	}
}

private struct TextPart: View {
	
	var body: some View {
		
		VStack(alignment: .center) {
			
			Text("Pope n Test").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 2)
			
			Text("live frame").foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 2)
		}
	}
}

//struct LiveClanComponent_Previews: PreviewProvider {
//	static var previews: some View {
//		LiveClanComponent()
//	}
//}
