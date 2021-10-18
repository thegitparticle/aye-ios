//
//  TalKCameraViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/18/21.
//

import Foundation
import Combine
import AVFoundation
import Camera_SwiftUI

final class TalkCameraViewModel: ObservableObject {
	private let service = CameraService()
	
	@Published var photoClicked: Photo!
	
	@Published var showAlertError = false
	
	@Published var isFlashOn = false
	
	var session: AVCaptureSession
	
	private var subscriptions = Set<AnyCancellable>()
	
	init() {
		self.session = service.session
		
		service.$photo.sink { [weak self] (photo) in
			guard let pic = photo else { return }
			self?.photoClicked = pic 
		}
		.store(in: &self.subscriptions)
		
		service.$flashMode.sink { [weak self] (mode) in
			self?.isFlashOn = mode == .on
		}
		.store(in: &self.subscriptions)
	}
	
	func configure() {
		service.checkForPermissions()
		service.configure()
	}
	
	func capturePhoto() {
		service.capturePhoto()
	}
	
	func flipCamera() {
		service.changeCamera()
	}
	
	func zoom(with factor: CGFloat) {
		service.set(zoom: factor)
	}
	
	func switchFlash() {
		service.flashMode = service.flashMode == .on ? .off : .on
	}
}
