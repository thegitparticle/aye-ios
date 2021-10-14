//
//  NudgeItemComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct NudgeItemComponent: View {
	
	var body: some View {
		
		HStack (alignment: .center) {
			
			KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaw.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
				.cornerRadius(50.0)
			
			Text("Daven Willians").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 3)
			
			Spacer()
			
			StartButtonHere()
			
		}.frame(maxWidth: .infinity).padding(20)
	}
}

private struct StartButtonHere: View {
	
	var body: some View {
		
		ZStack {
			
			RoundedRectangle(cornerRadius: 15, style: .continuous).frame(width: 75, height: 30)
				.padding()
				.foregroundColor(LightTheme.Colors.sucesss.opacity(0.25))
			
			Text("START").foregroundColor(LightTheme.Colors.sucesss).font(LightTheme.Typography.subtitle2)
			
		}
	}
}

struct NudgeItemComponent_Previews: PreviewProvider {
	static var previews: some View {
		NudgeItemComponent()
	}
}
