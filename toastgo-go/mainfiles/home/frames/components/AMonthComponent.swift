//
//  AMonthComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/21/21.
//

import SwiftUI

struct AMonthComponent: View {
	
	@StateObject private var viewModel = FramesListViewModel()
	
	var clubName: String     // in directs, its the other user's name
	var clubId: Int 			// in directs, its the other user's id
	var channelId: String
	var ongoingFrame: Bool
	var startTime: String
	var endTime: String
	var ongoingStream: Bool
	var ongoingStreamUser: String
	var directornot: Bool
	
	var my_id: Int
	var my_name: String
	
	var renderMonth: Int
	var renderMonthString: String
	
	var framesListHere: [ClanFramesListItem]
	
    var body: some View {
		
		ScrollView {
			
			LazyVStack {
				
				ForEach(framesListHere, id: \.id) {item in
					
					Text("frame here")
					
					Text(item.frame_picture_link)
				}
			}
			
		}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		
    }
	
}

//struct AMonthComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        AMonthComponent()
//    }
//}
