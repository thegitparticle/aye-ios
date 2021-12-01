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
	
	var aNewMessage: PubNubMessage
	
	var imageViewTriggerFunction: (String) -> ()
	
	var body: some View {
		
		if (aNewMessage is PubNubMessage) {
			
			NormalMessage(aNewMessage: aNewMessage as! PubNubMessage, imageViewTriggerFunction: imageViewTriggerFunction)
			
		}  else if (aNewMessage as? PubNubFileEvent != nil) {
			
			
			FileMessage(aNewMessage: aNewMessage as! PubNubFileEvent, imageViewTriggerFunction: imageViewTriggerFunction)
			
		} else {
			
			VStack {
				
				Text("unable message type" as String).foregroundColor(Color.blue)
				
			}
		}
		
	}
	
}

struct FileMessage: View {
	
	var aNewMessage: PubNubFileEvent
	var imageViewTriggerFunction: (String) -> ()
	
	var body: some View {
		
		ZStack () {
			
			KFAnimatedImage.url(URL(string: (self.aNewMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)!).cornerRadius(10).frame(width: .infinity, height: 200).onPress {
				
				imageViewTriggerFunction((self.aNewMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)
			}
			
			ZStack {
				
				Text("" as String).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 10).background(LightTheme.Colors.uiSurface)
				
				KFAnimatedImage.url(URL(string: (self.aNewMessage.metadata?.rawValue as! [String: Any])["user_dp"] as! String)!).cornerRadius(25).frame(width: 50, height: 50)
				
			}.cornerRadius(5).padding(.top, 180).onAppear() {
				
				print("cmessagelive \(self.aNewMessage.metadata as! String)")
				print("cmessagelive \(self.aNewMessage.additionalMessage as! String)")
				print("cmessagelive \(self.aNewMessage.file as! String)")
			}
			
		}.padding(.horizontal, 20).padding(.vertical, 20)

		
	}
}

struct NormalMessage: View {
	
	var aNewMessage: PubNubMessage
	var imageViewTriggerFunction: (String) -> ()
	@State private var playVideo: Bool = true
	
	var body: some View {
	
		if ((self.aNewMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "h") {
		
			HMessageComponent.onAppear() {
			
				print("cmessagelive - one h message")
			}
		
		} else if ((self.aNewMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "s") {
		
			SMessageComponent.onAppear() {
			
				print("cmessagelive - one s message")
			}
		
		}
		
		else if ((self.aNewMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "c") {
			
			SMessageComponent.onAppear() {
				
				print("cmessagelive - one c message")
			}
			
		}
		
		else {
		
			VStack {
			
				Text("unable message type" as String).foregroundColor(Color.blue)
			
			}
		}
		
	}
	
	var SMessageComponent: some View {
		
		ZStack () {
			
			VideoPlayer(url: URL(string: (self.aNewMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)!, play: self.$playVideo)
			
			ZStack {
				
				Text("\(self.aNewMessage.payload.rawValue)" as String).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 10).background(LightTheme.Colors.uiSurface)
				
			}.cornerRadius(5).padding(.top, 180)
			
		}.padding(.horizontal, 20).padding(.vertical, 20)
		
	}
	
	var HMessageComponent: some View {
		
		ZStack () {
			
			KFAnimatedImage.url(URL(string: (self.aNewMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)!).cornerRadius(10).frame(width: .infinity, height: 200).onPress {
				
				imageViewTriggerFunction((self.aNewMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)
			}
			
			ZStack {
				
				Text("\(self.aNewMessage.payload.rawValue)" as String).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 10).background(LightTheme.Colors.uiSurface)
				
			}.cornerRadius(5).padding(.top, 180)
			
		}.padding(.horizontal, 20).padding(.vertical, 20)
		
	}
	
}
