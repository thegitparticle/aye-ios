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
import VideoPlayer

struct NewMessageComponent: View {
	
	@State private var playVideo: Bool = true
	
	var aNewMessage: AnyNewMessage
	
	var imageViewTriggerFunction: (String) -> ()
	
	var body: some View {
		
		ZStack () {
			
			KFAnimatedImage.url(URL(string: self.aNewMessage.base_image)).cornerRadius(10).frame(width: .infinity, height: 200).onPress {
				
				imageViewTriggerFunction(self.aNewMessage.base_image)
			}
			
			ZStack {
				
				Text("\(self.aNewMessage.message)" as String).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 10).background(LightTheme.Colors.uiSurface)
				
			}.cornerRadius(5).padding(.top, 180)
			
		}.padding(.horizontal, 20).padding(.vertical, 20)
		
	}
	
}

