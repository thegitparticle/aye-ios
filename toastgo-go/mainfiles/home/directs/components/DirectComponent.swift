//
//  DirectComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct DirectComponent: View {
	
	var directHere: MyDirectsDataClass
	
	var body: some View {
		
		HStack (alignment: .center) {
			
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: directHere.display_guys.profile_picture)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
					.cornerRadius(50.0)
				
				
				VStack(alignment: .leading) {
					
					Text(directHere.display_guys.full_name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
					
					Text("tap and start new frame").foregroundColor(LightTheme.Colors.textPrimary.opacity(0.2)).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 1)
				}
				
				Spacer()
			}
			
		}.frame(maxWidth: .infinity).padding(.vertical, 10)
		
	}
}

//struct DirectComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectComponent()
//    }
//}