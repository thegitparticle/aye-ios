//
//  MyDirectsScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI

struct MyDirectsScreen: View {
	
	var directsListHere: [MyDirectsDataClass]
	var nudgeListHere: [NudgeListItemDataClass]
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
				
				ForEach(directsListHere, id: \.direct_channel_id) {item in
					
					DirectComponent(directHere: item)
				}
				
				Spacer().frame(height: 50)
				
				ForEach(nudgeListHere, id: \.id) {item in
					
					NudgeItemComponent(nudgeItemHere: item)
				}
				
				Spacer().frame(height: 200)
				
			}.padding(.top, 75).padding(.horizontal, 20)
			
		}
		
	}
}

//struct MyDirectsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MyDirectsScreen()
//    }
//}
