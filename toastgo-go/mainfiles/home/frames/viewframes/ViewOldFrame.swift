//
//  ViewOldFrame.swift
//  toastgo-go
//
//  Created by SAN on 10/23/21.
//

import SwiftUI

struct ViewOldFrame: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@StateObject private var viewModel = ViewOldFrameViewModel()
	@StateObject private var pubnubSetUp = PubnubSetup()
	
	var clubName: String     // in directs, its the other user's name
	var clubId: Int 			// in directs, its the other user's id
	var channelId: String
	
	var oldFrameStartTime: String
	var oldFrameEndTime: String
	var directornot: Bool
	
	var my_id: Int
	var my_name: String
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack {
				
				if (viewModel.messagesOfThisFrame.count > 0) {
					
					ScrollView {
						
						LazyVStack {
							
							Spacer().frame(height: 200)
							
							ForEach(viewModel.messagesOfThisFrame, id: \.published) {item in
								
								OldMessageComponent(anOldMessage: item, channelId: channelId)
								
							}
							
							Spacer().frame(height: 200)
							
						}
					}
				}
			}
			
			HeaderHere
		}
		
    }
	
	var HeaderHere: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground).shadow(color: LightTheme.Colors.textSecondary.opacity(0.05), radius: 40, x: 0, y: 10)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_arrow_back).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Text(clubName).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
					
					Spacer()
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}.onAppear() {
			
			viewModel.getOldMessagesOfThisFrameFromPn(channelId: channelId, start: (Int(oldFrameStartTime) ?? 0) * 10000000, end: (Int(oldFrameEndTime) ?? 0) * 10000000, pubnubConfig: pubnubSetUp)
		}
		
	}
	
}

//struct ViewOldFrame_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewOldFrame()
//    }
//}
