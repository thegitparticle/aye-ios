//
//  CapsuleSpacingWorkingOnItAnimationSmall.swift
//  toastgo-go
//
//  Created by SAN on 12/2/21.
//

import Foundation
import SwiftUI

struct CapsuleSpacingSmall: View {

	@State private var spacingAnimation = false

	@State private var scaleValue = 0.2

	var body: some View {

		HStack(spacing: spacingAnimation ? CGFloat(3) : CGFloat(1)) {

			Capsule(style: .continuous)
				.fill(Color(#colorLiteral(red: 0.02352941176, green: 0.8392156863, blue: 0.6274509804, alpha: 1)))
				.frame(width: 2, height: 12)

			Capsule(style: .continuous)
				.fill(Color(#colorLiteral(red: 1, green: 0.8196078431, blue: 0.4, alpha: 1)))
				.frame(width: 2, height: 8)

			Capsule(style: .continuous)
				.fill(Color(#colorLiteral(red: 0.937254902, green: 0.2784313725, blue: 0.4352941176, alpha: 1)))
				.frame(width: 2, height: 12)

			Capsule(style: .continuous)
				.fill(Color(#colorLiteral(red: 1, green: 0.8196078431, blue: 0.4, alpha: 1)))
				.frame(width: 2, height: 8)

			Capsule(style: .continuous)
				.fill(Color(#colorLiteral(red: 0.02352941176, green: 0.8392156863, blue: 0.6274509804, alpha: 1)))
				.frame(width: 2, height: 12)
		}
		.animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
		.onAppear {
			spacingAnimation.toggle()
		}

	}
}
