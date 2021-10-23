//
//  AMonthComponentDirects.swift
//  toastgo-go
//
//  Created by SAN on 10/23/21.
//

import SwiftUI

struct AMonthComponentDirects: View {
	
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
	
	var thisMonth = 0
	var thisMonthString = ""
	
	var framesListHere: [DirectFramesListItem]
	
	var daysInThisMonth: Int
	
	@State var todayDate = Date().day
	
	let oneStripRange = 1...10
	let twoStripRange = 11...20
	
	var body: some View {
		
		ScrollView {
			
			LazyVStack {
				
				HStack {
					
					if (thisMonth == renderMonth) {
						
						if (self.todayDate < 11) {
							
							AStripComponentDirects(startDate: 1, endDate: self.todayDate, framesListHere: self.framesListHere)
							
						} else if (self.twoStripRange.contains(self.todayDate)) {
							
							AStripComponentDirects(startDate: 1, endDate: 10, framesListHere: self.framesListHere)
							AStripComponentDirects(startDate: 11, endDate: self.todayDate, framesListHere: self.framesListHere)
							
						} else if (self.todayDate > 20) {
							
							AStripComponentDirects(startDate: 1, endDate: 10, framesListHere: self.framesListHere)
							AStripComponentDirects(startDate: 11, endDate: 20, framesListHere: self.framesListHere)
							AStripComponentDirects(startDate: 11, endDate: self.todayDate, framesListHere: self.framesListHere)
							
						} else {
							
							AStripComponentDirects(startDate: 1, endDate: 10, framesListHere: self.framesListHere)
							AStripComponentDirects(startDate: 11, endDate: 20, framesListHere: self.framesListHere)
							AStripComponentDirects(startDate: 21, endDate: daysInThisMonth, framesListHere: self.framesListHere)
							
						}
					} else {
						
						AStripComponentDirects(startDate: 1, endDate: 10, framesListHere: self.framesListHere)
						AStripComponentDirects(startDate: 11, endDate: 20, framesListHere: self.framesListHere)
						AStripComponentDirects(startDate: 21, endDate: daysInThisMonth, framesListHere: self.framesListHere)
					}
					
				}
				
			}
			
		}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		
	}
}

//struct AMonthComponentDirects_Previews: PreviewProvider {
//    static var previews: some View {
//        AMonthComponentDirects()
//    }
//}
