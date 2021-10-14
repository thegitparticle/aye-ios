//
//  MyDirectsScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI

struct MyDirectsScreen: View {
	
    var body: some View {
		
		VStack {
			
			DirectComponent()
			
			NudgeItemComponent()
		}
    }
}

struct MyDirectsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyDirectsScreen()
    }
}
