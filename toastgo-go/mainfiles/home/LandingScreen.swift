//
//  LandingScreen.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

struct LandingScreen: View {
	
	@State private var buttonActive: Bool = false
	
	@State private var selectedTab = 0
	
	let numTabs = 2
	let minDragTranslationForSwipe: CGFloat = 50
	
    var body: some View {
			TabView(selection: $selectedTab) {
				
				NavigationView{
					Text("Hello, World!")
				}.tabItem {
					Image(systemName: "house")
					Text("Home")
				}.tag(0)
				.highPriorityGesture(DragGesture().onEnded({
					self.handleSwipe(translation: $0.translation.width)
				}))
				
				NavigationView{
					Text("Salut, tout le monde!")
				}.tabItem {
					Image(systemName: "timelapse")
					Text("Space")
				}.tag(1)
				.highPriorityGesture(DragGesture().onEnded({
					self.handleSwipe(translation: $0.translation.width)
				}))
				
			}.navigationBarHidden(true)
    }
	
	private func handleSwipe(translation: CGFloat) {
		if translation > minDragTranslationForSwipe && selectedTab > 0 {
			selectedTab -= 1
		} else  if translation < -minDragTranslationForSwipe && selectedTab < numTabs-1 {
			selectedTab += 1
		}
	}
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
