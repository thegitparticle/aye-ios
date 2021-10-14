//
//  MyClansScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct MyClansScreen: View {
	
    var body: some View {
		
		ScrollView {
		VStack {
			
			LiveClanComponent()
			
			DormantClanComponent()
		}
		}
    }
}

struct MyClansScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyClansScreen()
    }
}
