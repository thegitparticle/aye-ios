//
//  LightTheme.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import Foundation
import SwiftUI
import UIKit

enum LightTheme{
	enum Colors{
		static let brand:Color = Color(hex: 0xFF6B5DD3)
		static let brandVariant:Color = Color(hex: 0xFF998FE0)
		static let appLead:Color = Color(hex: 0xFF3F8CFF)
		static let appLeadVariant:Color = Color(hex: 0xFF82B4FF)
		static let uiBackground:Color = Color(hex: 0xFFFFFFFF)
		static let uiSurface:Color = Color(hex: 0xFFF2F2F3)
		static let error:Color = Color(hex: 0xFFF32013)
		static let textPrimary:Color = Color(hex: 0xFF050505)
		static let textSecondary:Color = Color(hex: 0xFF161616)
		static let textSpecial:Color = Color(hex: 0xFFEF4F2B)
		static let textLink:Color = Color(hex: 0xFF1ABCFE)
		static let iconBackground:Color = Color(hex: 0xFFF2F2F3)
		static let iconVector:Color = Color(hex: 0xFF161616)
		static let sucesss:Color = Color(hex: 0xFF0ACF83)
		static let notification: Color = Color(hex: 0xFF5EF9BE)
		static let special1: Color = Color(hex: 0xFFFE754D)
		static let special2: Color = Color(hex: 0xFFF5FAFC)
		static let special3: Color = Color(hex: 0xFF1ABCFE)
		static let special4: Color = Color(hex: 0xFF26EEFF)
	}
	
	enum Typography {
		static let h1:Font = Font.custom("GothamRounded-Bold", size: 34)
		static let h2:Font = Font.custom("GothamRounded-Bold", size: 28)
		static let h3:Font = Font.custom("GothamRounded-Bold", size: 22)
		static let h4:Font = Font.custom("GothamRounded-Bold", size: 20)
		static let h5:Font = Font.custom("GothamRounded-Medium", size: 17)
		static let subtitle1:Font = Font.custom("GothamRounded-Medium", size: 15)
		static let body1:Font = Font.custom("GothamRounded-Book", size: 15)
		static let subtitle2:Font = Font.custom("GothamRounded-Medium", size: 13)
		static let subtitle2I:Font = Font.custom("GothamRounded-MediumItalic", size: 13)
		static let body2:Font = Font.custom("GothamRounded-Book", size: 13)
		static let caption:Font = Font.custom("GothamRounded-Light", size: 11)
	}
}

extension Color {
	init(hex: UInt, alpha: Double = 1) {
		self.init(
			.sRGB,
			red: Double((hex >> 16) & 0xff) / 255,
			green: Double((hex >> 08) & 0xff) / 255,
			blue: Double((hex >> 00) & 0xff) / 255,
			opacity: alpha
		)
	}
}
