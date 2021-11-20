//
//  ImageViewerDataClass.swift
//  toastgo-go
//
//  Created by SAN on 10/20/21.
//

import Foundation
import Combine

class ImageViewDataClass: ObservableObject {
	
	@Published var showImageOverlayViewer = false
	@Published var overlayImageURL = "https://..."
	
	func changeImageOverlayState () {
		
		showImageOverlayViewer = true
	}
	
	func changeImageOverlayLink (link: String) {
		
		overlayImageURL = link
	}
}
