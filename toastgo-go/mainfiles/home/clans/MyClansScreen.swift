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
			
		List {
	
			ForEach(clansListHere, id: \.club_id) {item in
			
				DormantClanComponent(clanHere: item)
			}
		
			Spacer().frame(height: 200)
			
		}.padding(.top, 75)
		
	}
}

//struct MyClansScreen_Previews: PreviewProvider {
//	static var previews: some View {
//		MyClansScreen()
//	}
//}
