//
//  OldMessageComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/19/21.
//

import SwiftUI
import PubNub
import Kingfisher
import ImageViewerRemote

struct OldMessageComponent: View {
	
	@StateObject private var pubnubSetUp = PubnubSetup()
	
	var anOldMessage: PubNubMessage
	var channelId: String
	
//	@StateObject var imageViewer = ImageViewDataClass()
	
	var body: some View {
		
		
		if ((self.anOldMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "c") {
			
			CMessageComponent
			
		} else if ((self.anOldMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "h") {
			
			HMessageComponent
			
		} else {
			
			VStack {
				
				Text("unable message type" as String).foregroundColor(Color.blue)
				
			}
		}
		
	}
	
	var CMessageComponent: some View {
		
		ZStack () {
			
			KFImage.url(grabURLFromPubNub(name: "galgalga", Id: ((self.anOldMessage.payload.rawValue as! [String: Any])["file"] as! [String: Any])["id"] as! String)).resizable().cornerRadius(10).frame(width: .infinity, height: 200).onPress {
//				imageViewer.showImageOverlayViewer = true
			}
			
			ZStack {
				
				Text("\(self.anOldMessage.payload.rawValue)" as String).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 10).background(LightTheme.Colors.uiSurface)
				
			}.cornerRadius(5).padding(.top, 180)
			
		}.padding(.horizontal, 20).padding(.vertical, 20)
		
	}
	
	private func grabURLFromPubNub (name: String, Id: String) -> URL {
		
		var downloadURL: URL = URL(fileURLWithPath: "")
		
		do {
			downloadURL = try pubnubSetUp.pubnub.generateFileDownloadURL(channel: channelId, fileId: ((self.anOldMessage.payload.rawValue as! [String: Any])["file"] as! [String: Any])["id"] as! String, filename: "galgalgal")
			print("got pic from pn")
//			imageViewer.overlayImageURL = downloadURL.absoluteString
		} catch {
			downloadURL = URL(fileURLWithPath: "")
		}
		
		return downloadURL
	}
	
	
	var HMessageComponent: some View {
		
		ZStack () {
			
			KFImage.url(URL(string: (self.anOldMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)!).resizable().cornerRadius(10).frame(width: .infinity, height: 200).onPress {
//				self.imageViewer.overlayImageURL = (self.anOldMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String
//				self.imageViewer.showImageOverlayViewer = true
				
//				imageViewer.changeImageOverlayLink(link: (self.anOldMessage.metadata?.rawValue as! [String: Any])["image_url"] as! String)
//				imageViewer.changeImageOverlayState()
			}
			
			ZStack {
				
				Text("\(self.anOldMessage.payload.rawValue)" as String).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 10).background(LightTheme.Colors.uiSurface)
				
			}.cornerRadius(5).padding(.top, 180)
			
		}.padding(.horizontal, 20).padding(.vertical, 20)
	}
	
}


//
//struct OldMessageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        OldMessageComponent()
//    }
//}
