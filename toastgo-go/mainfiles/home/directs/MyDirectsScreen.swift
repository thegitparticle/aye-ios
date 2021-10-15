//
//  MyDirectsScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI

struct MyDirectsScreen: View {
	
	var directsListHere: [MyDirectsDataClass]
	
    var body: some View {
		
		VStack {
			
			List (directsListHere, id: \.direct_channel_id) { item in
				DirectComponent()
			}.onAppear() {
				print("debuglandingsetup", directsListHere)
			}
			
//			NudgeItemComponent()
		}
    }
}

//struct MyDirectsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MyDirectsScreen()
//    }
//}
