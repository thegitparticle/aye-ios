//
//  CheckInvitedOrNotScreen.swift
//  toastgo-go
//
//  Created by SAN on 12/3/21.
//

import SwiftUI

struct CheckInvitedOrNotScreen: View {
	
	@StateObject private var viewModel = CheckInvitedOrNotViewModel()
	
	var phoneNumber: String
	var countryCode: String
	var userDeets: UserDetailsDataClass
	
	@State private var activateLandingScreenNav = false
	
	@State private var landingNavButtonActive: Bool = false
	
	@State private var showStartClanModal = false
	
    var body: some View {
		
		ZStack(alignment: .leading) {
			
			NavigationLink(destination: LandingScreen(), isActive: self.$landingNavButtonActive) {EmptyView()}
			
			VStack() {
				
				Spacer()
				
				HStack(alignment: .center) {
					
					if (viewModel.invitedOrNotStatus.count == 0) {
						
						LottieView(filename: "loading_ping_pong_cup")
						
					} else {
						
						if (viewModel.invitedOrNotStatus == "None") {
							
							Text("start clan to get started ").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20).onAppear() {
								
								self.showStartClanModal = true
							}
							
						} else {
						
							Text("all set to go 🚀 ").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.h5).padding(20)
							
						}
					}
					
				}.padding(20).frame(maxWidth: .infinity, maxHeight: 200).onAppear() {
					
					viewModel.getCheckInvitedOrNotApi(phone: countryCode + phoneNumber)
				}
							
				Spacer()
				
				if (viewModel.invitedOrNotStatus.count > 1) {
					Button(action: {
						
						UserDefaults.standard.set(true, forKey: "LoginState");
						self.landingNavButtonActive = true

					}) {
						Text("DIVE IN")
							.frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 40)
							.padding()
							.font(LightTheme.Typography.h5)
							.foregroundColor(LightTheme.Colors.uiSurface)
							.background(LightTheme.Colors.textSecondary)
							.cornerRadius(50)
					}
					.padding(.vertical).padding(20)
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity).sheet(isPresented: $showStartClanModal) {
			
				StartClanScreen()
			}
			
		}.navigationBarHidden(true).background(LightTheme.Colors.textPrimary).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
}

//struct CheckInvitedOrNotScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckInvitedOrNotScreen()
//    }
//}
