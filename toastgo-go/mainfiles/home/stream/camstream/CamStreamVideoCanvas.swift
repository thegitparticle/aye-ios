//
//  CamStreamVideoCanvas.swift
//  toastgo-go
//
//  Created by SAN on 10/21/21.
//

import Foundation
import SwiftUI

struct CamStreamVideoCanvas : UIViewRepresentable {
	let rendererView = UIView()
	
	func makeUIView(context: Context) -> UIView {
		rendererView.backgroundColor = UIColor.gray
		return rendererView
	}
	
	func updateUIView(_ uiView: UIView, context: Context) { }
}
