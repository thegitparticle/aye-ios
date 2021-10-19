//
//  OldMessageComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/19/21.
//

import SwiftUI
import PubNub

struct OldMessageComponent: View {
	
	var anOldMessage: PubNubMessage
	
//	let x_here = self.anOldMessage.metadata?.rawValue as! [String: Any]
	
	var body: some View {
		
//		for (key, value) in self.anOldMessage.metadata?.rawValue as! [String: Any] {
//
//			if (key == "type") {
					
		if ((self.anOldMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "c") {
					VStack {
						
						Text("\(self.anOldMessage.payload.rawValue)" as String)
						
					}
					
		} else if ((self.anOldMessage.metadata?.rawValue as! [String: Any])["type"] as! String == "h") {
					
					VStack {
						
						Text("\(self.anOldMessage.payload.rawValue)" as String).foregroundColor(Color.blue)
						
					}
					
				} else {
					
					VStack {
						
						Text("unable message type" as String).foregroundColor(Color.blue)
						
					}
				}
//			}
//
//		}
		
	}
}


//
//struct OldMessageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        OldMessageComponent()
//    }
//}
