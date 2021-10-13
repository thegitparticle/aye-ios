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
	var iconName: IonIconsCode

	public init (size: Int = 20, iconName: IonIconsCode = .ios_apps) {
		self.size = size
		self.iconName = iconName
	}

    var body: some View {

		ZStack() {
			Circle().frame(width: CGFloat((self.size))*1.5, height: CGFloat((self.size))*1.5)
				.padding()
				.foregroundColor(LightTheme.Colors.iconBackground)
				.background(LightTheme.Colors.iconBackground)
				.cornerRadius(70)
			FontIcon.text(.ionicon(code: self.iconName), fontsize: CGFloat(self.size)).foregroundColor(LightTheme.Colors.iconVector)
		}
    }
}

struct CircleIconAuthFlow: View {

	var size: Int
	var iconName: IonIconsCode

	public init (size: Int = 20, iconName: IonIconsCode = .ios_apps) {
		self.size = size
		self.iconName = iconName
	}

	var body: some View {

		ZStack {
			Circle().frame(width: CGFloat((self.size))*1.5, height: CGFloat((self.size))*1.5)
				.padding()
				.foregroundColor(LightTheme.Colors.textSecondary)
				.background(LightTheme.Colors.textSecondary)
				.cornerRadius(70)
			FontIcon.text(.ionicon(code: self.iconName), fontsize: CGFloat(self.size)).foregroundColor(LightTheme.Colors.uiSurface.opacity(0.75))

		}
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
