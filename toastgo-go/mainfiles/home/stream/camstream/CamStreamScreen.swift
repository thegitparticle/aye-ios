//
//  CamStreamScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/20/21.
//

import SwiftUI

struct CamStreamScreen: View {
	
	@StateObject private var viewModel = CamStreamViewModel()
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	var clubName: String     // in directs, its the other user's name
	var clubId: Int 			// in directs, its the other user's id
	var channelId: String
	var ongoingFrame: Bool
	var startTime: String
	var endTime: String
	var ongoingStream: Bool
	var ongoingStreamUser: String
	var directornot: Bool
	
	var my_id: Int
	var my_name: String
	
	
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//struct CamStreamScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        CamStreamScreen()
//    }
//}
