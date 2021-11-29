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
	
	var my_id: Int
	var my_name: String
	
	var refreshFunction: () -> Bool
	
	@State private var showInvitePeopleModal = false
	
	//	var defaultRecosPassing: [DefaultRecosDataClass]
	
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
					
					DirectComponent(directHere: item, my_id: my_id, my_name: my_name)
				}
				
				Spacer().frame(height: 50)
				
				Text("MORE FRIENDS").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.h5).padding(.horizontal, 10).padding(.vertical, 1)
				
				Spacer().frame(height: 50)
				
				if (nudgeListHere.count > 0) {
					
					ForEach(nudgeListHere, id: \.id) {item in
						
						NudgeItemComponent(nudgeItemHere: item)
					}
					
				} else {
					
					ZStack {
						
						RoundedRectangle(cornerRadius: 30, style: .continuous)
							.fill(LightTheme.Colors.appLead)
							.frame(width: 180, height: 60)
						
						Text("invite friends").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
						
					}.onPress {
						
						self.showInvitePeopleModal = true
					}
					
				}
				
				Spacer().frame(height: 200)
				
			}.padding(.top, 75).padding(.horizontal, 20).sheet(isPresented: $showInvitePeopleModal) {
				
				InviteContactsScreen()
			}
			
		}
		
	}
}

//struct MyDirectsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MyDirectsScreen()
//    }
//}
