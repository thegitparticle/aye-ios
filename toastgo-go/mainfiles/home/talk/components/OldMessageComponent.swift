//
//  OldMessageComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/19/21.
//

import SwiftUI
import PubNub
import Kingfisher

struct OldMessageComponent: View {
	
	var anOldMessage: PubNubMessage
	
	var body: some View {
		
		
		if ((self.anOldMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "c") {
			VStack {
				
				Text("\(self.anOldMessage.payload.rawValue)" as String)
				
			}
			
		} else if ((self.anOldMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "h") {
			
			HMessageComponent
			
		} else {
			
			VStack {
				
				Text("unable message type" as String).foregroundColor(Color.blue)
				
			}
		}
		
	}
	
	
	var HMessageComponent: some View {
		
		VStack () {
			
			KFImage.url(URL(string: (self.anOldMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)!).resizable().cornerRadius(10).frame(width: .infinity, height: 200)
			
			ZStack {
				
				Text("\(self.anOldMessage.payload.rawValue)" as String).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 10).background(LightTheme.Colors.uiSurface)
				
			}.offset(y: -20).cornerRadius(5)
			
		}.padding(.horizontal, 20).padding(.vertical, 20)
		
	}
	
}


//
//struct OldMessageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        OldMessageComponent()
//    }
//}
