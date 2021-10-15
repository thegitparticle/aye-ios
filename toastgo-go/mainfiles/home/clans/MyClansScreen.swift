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
	
	var body: some View {
			
		List (clansListHere, id: \.club_id) { item in
			Text("tap to start new frame").foregroundColor(LightTheme.Colors.textPrimary.opacity(0.2)).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 3)
				DormantClanComponent(clanHere: item)
		}.onAppear() {
			print("debuglandingsetup", clansListHere)
		}
	}
}

//struct MyClansScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		MyClansScreen()
//	}
//}
