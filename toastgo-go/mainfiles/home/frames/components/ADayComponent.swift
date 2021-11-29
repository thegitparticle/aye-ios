//
//  ADayComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/23/21.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct ADayComponent: View {
	
	@StateObject private var viewModel = FramesListViewModel()
	
	var whichDay: Int
	
	var framesListHere: [ClanFramesListItem]
	
	var clubName: String     // in directs, its the other user's name
	var clubId: Int 			// in directs, its the other user's id
	var channelId: String
	
	@State var daysFramesList = [ClanFramesListItem]()
	
	@State private var showOldFrameModal = false
	
	var body: some View {
		
		VStack {
			
			if (daysFramesList.count > 0) {
				
				ForEach(self.daysFramesList, id: \.id) {item in
					
					VStack {
						
						ZStack {
							
							RoundedRectangle(cornerRadius: 10, style: .continuous)
								.fill(Color.gray.opacity(0.5))
								.frame(width: 55, height: 55)
							
							KFImage.url(URL(string: item.frame_picture_link)).resizable().cornerRadius(10).frame(width: 55, height: 55)
								.cornerRadius(10.0)
							
						}.onAppear() {
							
							print("framepicdebug" + item.frame_picture_link)
							print("framepicdebug" + item.published_date)
						}
						
					}.sheet(isPresented: $showOldFrameModal) {
						
						ViewOldFrame(clubName: clubName, clubId: clubId, channelId: channelId, oldFrameStartTime: item.start_time, oldFrameEndTime: item.end_time, directornot: false, my_id: UserDefaults.standard.integer(forKey: "MyId"), my_name: UserDefaults.standard.string(forKey: "MyName") ?? "")
						
					}.onPress {
						
						self.showOldFrameModal = true
					}
					
				}
			} else {
				
				Text("\(self.whichDay)").foregroundColor(Color.white.opacity(0.75)).font(LightTheme.Typography.subtitle2)
			}
			
		}.onAppear() {
			
			checkForFrames()
		}
		
	}
	
	func checkForFrames() {
		
		for item in framesListHere {
			
			print("framepicdebug \(item.published_date)")
			
			if ((item.published_date).suffix(2) == String(self.whichDay) || (item.published_date).suffix(2) == "0" + String(self.whichDay)) {
				
				daysFramesList.append(item)
			}
		}
		
	}
}

//struct ADayComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ADayComponent()
//    }
//}
