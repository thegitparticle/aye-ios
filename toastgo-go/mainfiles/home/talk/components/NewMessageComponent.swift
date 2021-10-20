//
//  NewMessageComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/20/21.
//

import Foundation
import SwiftUI
import PubNub
import Kingfisher

struct NewMessageComponent: View {
	
	var aNewMessage: PubNubMessage
	
	var body: some View {
		
		
		if ((self.aNewMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "c") {
			VStack {
				
				Text("\(self.aNewMessage.payload.rawValue)" as String)
				
			}
			
		} else if ((self.aNewMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "h") {
			
			HMessageComponent
			
		} else {
			
			VStack {
				
				Text("unable message type" as String).foregroundColor(Color.blue)
				
			}
		}
		
	}
	
	
	var HMessageComponent: some View {
		
		ZStack () {
			
			KFImage.url(URL(string: (self.aNewMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)!).resizable().cornerRadius(10).frame(width: .infinity, height: 200)
			
			ZStack {
				
				Text("\(self.aNewMessage.payload.rawValue)" as String).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 10).background(LightTheme.Colors.uiSurface)
				
			}.cornerRadius(5).padding(.top, 180)
			
		}.padding(.horizontal, 20).padding(.vertical, 20)
		
	}
	
}
