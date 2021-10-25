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

final class StreamLandingViewModel: ObservableObject {
	
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
	
	func destroyCamera() {
		
		service.stop()
	}
	
	@Published var agoraToken: String = ""
	
	public func getAgoraToken(channelId: String) {
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/agora_token_generator/\(String(UserDefaults.standard.integer(forKey: "MyId")))/\(channelId)/") else {
			
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(String.self, from: data) {
					
					DispatchQueue.main.async {
						self.agoraToken = decodedResponse
					}
					return
				}
				
				print("debuguserdefs Fetch failed user deets: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
}
