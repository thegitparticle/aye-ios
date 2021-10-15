//
//  DormantClanComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct DormantClanComponent: View {
	
	var clanHere: MyClansDataClass
		
		var body: some View {
			
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: clanHere.club_profile_pic)!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0)
				
				VStack(alignment: .leading) {
					
					Text(clanHere.club_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 3)
					
					Text("tap to start new frame").foregroundColor(LightTheme.Colors.textPrimary.opacity(0.2)).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 3)
				}
				
				Spacer()
				
			}.frame(maxWidth: .infinity).padding(20)
			
		}
}

//struct DormantClanComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        DormantClanComponent()
//    }
//}
