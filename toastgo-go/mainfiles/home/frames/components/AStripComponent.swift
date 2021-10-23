//
//  AStripComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/22/21.
//

import SwiftUI

struct AStripComponent: View {
	
	var startDate: Int
	var endDate: Int
	
	var framesListHere: [ClanFramesListItem]
	
//	var thisMonth: Int
//	var renderMonth: Int
	
    var body: some View {
		
		ZStack(alignment: .center) {
			
			Rectangle()
				.fill(LightTheme.Colors.special1)
				.frame(width: 75, height: UIScreen.screenHeight * 0.7)
			
			
			VStack {
					
				ForEach (self.startDate ... self.endDate, id: \.self) { item in
					
					ADayComponent(whichDay: item, framesListHere: self.framesListHere)
				}
				
			}

		}
		
    }

}

//struct AStripComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        AStripComponent(startDate: 1, endDate: 10)
//    }
//}
