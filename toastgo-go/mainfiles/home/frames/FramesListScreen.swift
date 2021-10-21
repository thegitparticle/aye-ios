//
//  FramesListScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/21/21.
//

import SwiftUI
import SwiftUIFontIcon
import Time
import SwiftDate;

struct FramesListScreen: View {
	
	@StateObject private var viewModel = FramesListViewModel()
	@StateObject private var pubnubSetUp = PubnubSetup()
	
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
	
	@State var thisMonth = 0
	@State var thisMonthString = ""
	
	@State var renderMonth = 0
	@State var renderMonthString = ""
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack {
				
				Spacer(minLength: statusBarHeight)
				
				Spacer(minLength: 100)
				
				MonthChanger
				
				AMonthComponent(clubName: clubName, clubId: clubId, channelId: channelId, ongoingFrame: ongoingFrame, startTime: startTime, endTime: endTime, ongoingStream: ongoingStream, ongoingStreamUser: ongoingStreamUser, directornot: directornot, my_id: my_id, my_name: my_name, renderMonth: self.renderMonth, renderMonthString: self.renderMonthString, framesListHere: viewModel.framesList)
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).onAppear() {
				
				monthChangeControllerNow()
			}
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	func monthChangeControllerNow () {
		
		self.thisMonth = Date().month
		self.thisMonthString = giveMonthName(month: self.thisMonth)
		
		self.renderMonth = self.thisMonth
		self.renderMonthString = self.thisMonthString
		viewModel.getClubFramesPerMonth(month: String(self.renderMonth), clubId: String(clubId))
	}
	
	func monthChangeControllerIncrease () {
		
		self.renderMonth = self.renderMonth + 1
		self.renderMonthString = giveMonthName(month: self.renderMonth )
		viewModel.getClubFramesPerMonth(month: String(self.renderMonth), clubId: String(clubId))
	}
	
	func monthChangeControllerDecrease () {
		
		self.renderMonth = self.renderMonth - 1
		self.renderMonthString = giveMonthName(month: self.renderMonth)
		viewModel.getClubFramesPerMonth(month: String(self.renderMonth), clubId: String(clubId))
	}
	
	var MonthChanger: some View {
		
		HStack {
			
			ZStack() {
				
				Circle().frame(width: 25, height: 25)
					.padding()
					.foregroundColor(LightTheme.Colors.iconBackground)
					.background(LightTheme.Colors.iconBackground)
					.cornerRadius(70)
			
				FontIcon.text(.ionicon(code: .ios_arrow_back), fontsize: 25).foregroundColor(LightTheme.Colors.textPrimary).onPress {
					
					monthChangeControllerDecrease()
					print(self.renderMonthString)
				}
			}
			
			Spacer()
			
			Text(self.renderMonthString).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
			
			Spacer()
			
			ZStack() {
				
				Circle().frame(width: 25, height: 25)
					.padding()
					.foregroundColor(LightTheme.Colors.iconBackground)
					.background(LightTheme.Colors.iconBackground)
					.cornerRadius(70)
			
			FontIcon.text(.ionicon(code: .ios_arrow_forward), fontsize: 25).foregroundColor(LightTheme.Colors.textPrimary)
				
			}.onPress {
				monthChangeControllerIncrease()
				print(self.renderMonthString)
			}
			
		}.frame(width: .infinity, height: 100).padding(20)
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
					
					Spacer()
					
					Text(clubName).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(20)
					
					Spacer()
					
					HStack {
						
						Circle().frame(width: 20, height: 20)
							.padding()
							.foregroundColor(LightTheme.Colors.uiBackground)
							.background(LightTheme.Colors.uiBackground)
							.cornerRadius(70)
						
					}
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
	}
	
	private func giveMonthName (month: Int) -> String {
		
		if (month == 1) {
			
			return "JANUARY"
		} else if (month == 2) {
			
			return "FEBRUARY"
			
		} else if (month == 3) {
			
			return "MARCH"
		} else if (month == 4) {
			
			return "APRIL"
		} else if (month == 5) {
			
			return "MAY"
		} else if (month == 6) {
			
			return "JUNE"
		} else if (month == 7) {
			
			return "JULY"
		} else if (month == 8) {
			
			return "AUGUST"
		} else if (month == 9) {
			
			return "SEPTEMBER"
		} else if (month == 10) {
			
			return "OCTOBER"
		} else if (month == 11) {
			
			return "NOVEMBER"
		} else if (month == 12) {
			
			return "DECEMBER"
		} else  {
			
			return ""
		}
	}
	
}

//struct FramesListScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FramesListScreen()
//    }
//}
