//
//  Test.swift
//  toastgo-go
//
//  Created by SAN on 9/30/21.
//

import SwiftUI

enum Style{
	enum Test{
		enum Background{
			static let primary:Color = .black
			static let accent:Color = .blue
			static let error:Color = .red
		}
		enum Text{
			static let primary:Color = .white
			static let accent:Color = .white
			static let error:Color = .white
		}
	}
}

struct Test: View {
	var body: some View {
		VStack {
			Text("test jsdjk").foregroundColor(LightTheme.Colors.brand).font(LightTheme.Typography.h1)
			Text("test").foregroundColor(LightTheme.Colors.appLeadVariant).font(LightTheme.Typography.subtitle1)
		}
	}
}

struct Test_Previews: PreviewProvider {
	static var previews: some View {
		Test()
			.preferredColorScheme(.dark)
	}
}
