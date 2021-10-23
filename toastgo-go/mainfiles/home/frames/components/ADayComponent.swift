//
//  ADayComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/23/21.
//

import SwiftUI
import Kingfisher

struct ADayComponent: View {
	
	var whichDay: Int
	
	var framesListHere: [ClanFramesListItem]
	
	@State var daysFramesList = [ClanFramesListItem]()
	
	var body: some View {
		
		VStack {
			
			if (daysFramesList.count > 0) {
				
				ForEach(self.daysFramesList, id: \.id) {item in
					
					VStack {
					KFImage.url(URL(string: item.frame_picture_link)).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
						.cornerRadius(50.0)
					
						Text("\(item.published_date)").foregroundColor(Color.white.opacity(0.75)).font(LightTheme.Typography.subtitle2)
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
