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

//	@State var x: JSONCodable

    var body: some View {

		VStack {

			Text("\(self.anOldMessage.payload.rawValue)" as String)

		}
    }
}


//
//struct OldMessageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        OldMessageComponent()
//    }
//}
