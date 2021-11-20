//
//  AStripComponentDirects.swift
//  toastgo-go
//
//  Created by SAN on 10/23/21.
//

import SwiftUI

struct AStripComponentDirects: View {
	var startDate: Int
	var endDate: Int
	
	var framesListHere: [DirectFramesListItem]
	
	var clubName: String     // in directs, its the other user's name
	var clubId: Int 			// in directs, its the other user's id
	var channelId: String
	
	
	//	var thisMonth: Int
	//	var renderMonth: Int
	
	var body: some View {
		
		ZStack(alignment: .center) {
			
			Rectangle()
				.fill(LightTheme.Colors.special1)
				.frame(width: 75, height: UIScreen.screenHeight * 0.7)
			
			
			VStack {
				
				ForEach (self.startDate ... self.endDate, id: \.self) { item in
					
					ADayComponentDirects(whichDay: item, framesListHere: self.framesListHere, clubName: clubName, clubId: clubId, channelId: channelId )
				}
				
			}
			
		}
		
	}
}

//struct AStripComponentDirects_Previews: PreviewProvider {
//    static var previews: some View {
//        AStripComponentDirects()
//    }
//}
