//
//  ScreenShare100Canvas.swift
//  toastgo-go
//
//  Created by SAN on 11/2/21.
//

import Foundation
import SwiftUI

struct ScreenShare100Canvas: UIViewControllerRepresentable {
	
	func makeUIViewController(context: Context) -> BaseViewController {
		return ScreenShareMain()
	}
	
	func updateUIViewController(_ uiViewController: BaseViewController, context: Context) {
		
	}
	
}
