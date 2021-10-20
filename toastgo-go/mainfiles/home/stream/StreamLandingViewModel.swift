//
//  StreamLandingViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/20/21.
//

import Foundation
import Camera_SwiftUI
import Combine
import AVFoundation

class StreamLandingViewModel: ObservableObject {
	
	private let service = CameraService()
	
	var session: AVCaptureSession
	
	private var subscriptions = Set<AnyCancellable>()
	
	init() {
		
		self.session = service.session
	}
	
	func configure() {
		service.checkForPermissions()
		service.configure()
	}
}
