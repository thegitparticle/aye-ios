//
//  CircleIcon.swift
//  toastgo-go
//
//  Created by SAN on 10/12/21.
//

import SwiftUI
import SwiftUIFontIcon

struct CircleIcon: View {
	
	var size: Int
//	var iconName:
	
	public init (size: Int = 20) {
		self.size = size
	}
	
    var body: some View {
		Button(
			action: {
				// did tap
			},
			label: { FontIcon.text(.ionicon(code: .ios_apps), fontsize: CGFloat(self.size)).foregroundColor(LightTheme.Colors.iconVector) }
		)
		.frame(width: CGFloat((self.size))*1.5, height: CGFloat((self.size))*1.5)
		.padding()
		.foregroundColor(.white)
		.background(LightTheme.Colors.iconBackground)
		.cornerRadius(70)
    }
}

struct CircleIconAuthFlow: View {
	
	var size: Int
	//	var iconName:
	
	public init (size: Int = 17) {
		self.size = size
	}
	
	var body: some View {
		Button(
			action: {
				// did tap
			},
			label: { FontIcon.text(.ionicon(code: .ios_apps), fontsize: CGFloat(self.size)).foregroundColor(LightTheme.Colors.uiSurface.opacity(0.75)) }
		)
		.frame(width: CGFloat((self.size)), height: CGFloat((self.size)))
		.padding()
		.foregroundColor(.white)
		.background(LightTheme.Colors.textSecondary)
		.cornerRadius(70)
	}
}

struct CircleIcon_Previews: PreviewProvider {
    static var previews: some View {
		VStack{
			CircleIcon()
			CircleIconAuthFlow()
		}
    }
}
