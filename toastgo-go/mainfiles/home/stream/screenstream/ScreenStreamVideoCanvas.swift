//
//  ScreenStreamVideoCanvas.swift
//  toastgo-go
//
//  Created by SAN on 10/25/21.
//

import Foundation
import SwiftUI

struct ScreenStreamVideoCanvas : UIViewRepresentable {
	let rendererView = UIView()
	
	func makeUIView(context: Context) -> UIView {
		rendererView.backgroundColor = UIColor.gray
		return rendererView
	}
	
	func updateUIView(_ uiView: UIView, context: Context) { }
}
