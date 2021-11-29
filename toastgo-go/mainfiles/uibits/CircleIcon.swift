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
			
			Circle().frame(width: CGFloat(self.size), height: CGFloat(self.size))
				.padding()
				.foregroundColor(LightTheme.Colors.iconBackground)
				.background(LightTheme.Colors.iconBackground)
				.cornerRadius(70)
			
			FontIcon.text(.ionicon(code: self.iconName), fontsize: CGFloat(self.size)).foregroundColor(LightTheme.Colors.iconVector)
		}
    }
}

struct CircleIconSFSymbols: View {
	
	var size: Int
	var iconName: String
	
	var body: some View {
		
		ZStack() {
			
			Circle().frame(width: CGFloat(self.size), height: CGFloat(self.size))
				.padding()
				.foregroundColor(LightTheme.Colors.iconBackground)
				.background(LightTheme.Colors.iconBackground)
				.cornerRadius(70)
			
			Image(systemName: self.iconName).font(LightTheme.Typography.body2).foregroundColor(LightTheme.Colors.iconVector)
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
			
			Circle().frame(width: CGFloat(self.size), height: CGFloat(self.size))
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
			CircleIcon(size: 13, iconName: .ios_person_add)
			CircleIconAuthFlow(size: 13, iconName: .ios_person_add)
			CircleIconAuthFlow()
		}
    }
}
