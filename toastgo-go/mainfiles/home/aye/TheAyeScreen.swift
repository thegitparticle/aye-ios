//
//  TheAyeScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/25/21.
//

import SwiftUI

struct TheAyeScreen: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@State private var text: String = ""
	
	@State private var selectedText = ""
	
	@StateObject private var viewModel = TheAyeViewModel()
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				Spacer()
				
				Image("sup_in_red")
					.resizable()
					.scaledToFit()
					.frame(width: 200, height: 86)
				
				Spacer()
				
				
				ZStack(alignment: .center) {
					
					Rectangle().fill(Color.gray).frame(width: UIScreen.screenWidth * 0.7, height: 50).background(Color.gray).shadow(color: Color.white.opacity(0.05), radius: 40, x: 0, y: 10).cornerRadius(25)
					
					HStack(alignment: .center) {
						
						Spacer()
						
						Text("talk to founder").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
						
						Spacer()
						
					}
					
				}.frame(width: UIScreen.screenWidth, height: 100).padding(.bottom, 30).onPress {
					
					let fraction = Float.random(in: 0..<1)
					
					print(fraction)
					
					viewModel.getStartDirectChannel(otheruserid: String(fraction > 0.5 ? 81 : 82))
				}
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(Color.black)
			
			HeaderHere
			
		}.navigationBarHidden(true).background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	var HeaderHere: some View {
		
		ZStack {
			
			Rectangle().fill(Color.black).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(Color.black)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Spacer()
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
}

struct TheAyeScreen_Previews: PreviewProvider {
    static var previews: some View {
        TheAyeScreen()
    }
}
