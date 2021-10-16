//
//  MyClansScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct MyClansScreen: View {
	
	var clansListHere: [MyClansDataClass]
	var liveClansHere: [MyClansDataClass]
	var refreshFunction: () -> Bool
	
	@State private var now = Date()
	
	var body: some View {
		
		RefreshableScrollView(onRefresh: { done in
			DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
				self.refreshFunction()
				self.now = Date()
				done()
			}
		}) {
			
			LazyVStack {
				
				ForEach(liveClansHere, id: \.club_id) {item in
					
					LiveClanComponent(clanHere: item, indexInList: liveClansHere.firstIndex(of: item) ?? 0)
				}
				
				ForEach(clansListHere, id: \.club_id) {item in
					
					DormantClanComponent(clanHere: item)
				}
				
				Spacer().frame(height: 200)
				
			}.padding(.top, 75).padding(.horizontal, 20)
		}
		
	}
}

//struct MyClansScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		MyClansScreen()
//	}
//}
