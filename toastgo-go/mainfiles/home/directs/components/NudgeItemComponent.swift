//
//  NudgeItemComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct NudgeItemComponent: View {
	
	var nudgeItemHere: NudgeListItemDataClass
	
	var body: some View {
		
		HStack (alignment: .center) {
			
			HStack (alignment: .center) {
			
			KFImage.url(URL(string: nudgeItemHere.profile_pic)!).resizable().cornerRadius(22.5).frame(width: 55, height: 55)
				.cornerRadius(50.0)
			
			Text(nudgeItemHere.name).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 3)
			
			Spacer()
			
			StartButtonHere()
			}
			
		}.frame(maxWidth: .infinity).padding(.vertical, 10)
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

//struct NudgeItemComponent_Previews: PreviewProvider {
//	static var previews: some View {
//		NudgeItemComponent()
//	}
//}
