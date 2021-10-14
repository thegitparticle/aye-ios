//
//  DormantClanComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct DormantClanComponent: View {
		
		var body: some View {
			
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaw.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0)
				
				VStack(alignment: .leading) {
					
					Text("Daven Willians").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 3)
					
					Text("deviousdaven").foregroundColor(LightTheme.Colors.textPrimary.opacity(0.2)).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 3)
				}
				
				Spacer()
				
			}.frame(maxWidth: .infinity).padding(20)
			
		}
}

struct DormantClanComponent_Previews: PreviewProvider {
    static var previews: some View {
        DormantClanComponent()
    }
}
