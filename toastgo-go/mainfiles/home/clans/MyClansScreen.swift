//
//  MyClansScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher
import HighlightedTextEditor


struct MyClansScreen: View {
	
	var clansListHere: [MyClansDataClass]
	var liveClansHere: [MyClansDataClass]
	
	var my_id: Int
	var my_name: String
	
	var refreshFunction: () -> Bool
	
	@State private var showStartClanModal = false
	
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
				
				if (liveClansHere.count == 0 && clansListHere.count == 0) {
					
					VStack {
						
						Spacer().frame(height: UIScreen.screenHeight * 0.3)
						
						ZStack {
							
							RoundedRectangle(cornerRadius: 30, style: .continuous)
								.fill(LightTheme.Colors.sucesss)
								.frame(width: 180, height: 60)
							
							Text("start clan").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
							
						}.onPress {
							
							self.showStartClanModal = true
						}
						
						Spacer()
						
					}
					
				} else {
					
					ForEach(liveClansHere, id: \.club_id) {item in
						
						LiveClanComponent(clanHere: item, my_id: my_id,  my_name: my_name, indexInList: liveClansHere.firstIndex(of: item) ?? 0)
					}
					
					ForEach(clansListHere, id: \.club_id) {item in
						
						DormantClanComponent(clanHere: item, my_id: my_id, my_name: my_name)
					}
					
					Spacer().frame(height: 50)
					
					ZStack {
						
						RoundedRectangle(cornerRadius: 30, style: .continuous)
							.fill(LightTheme.Colors.sucesss)
							.frame(width: 180, height: 60)
						
						Text("start clan").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
						
					}.onPress {
						
						self.showStartClanModal = true
					}
					
					Spacer().frame(height: 200)
				}
				
				
				
			}.padding(.top, 75).padding(.horizontal, 20)
			
		}.sheet(isPresented: $showStartClanModal) {
			StartClanScreen()
		}
		
	}
}

//struct MyClansScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		MyClansScreen()
//	}
//}
