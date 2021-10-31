//
//  MyProfileViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class MyProfileViewModel: ObservableObject {
	
	@Published var userDeetsHere: UserDetailsDataClass = UserDetailsDataClass(bio: "", id: 0, image: "", user: User(phone: "", number_of_clubs_joined: 0, contact_list_sync_status: false, id: 0, country_code_of_user: "", username: "", clubs_joined_by_user: "", full_name: "", total_frames_participation: 0, contact_list: ""))
	
	init () {
		
		getUserDetailsHere()
	}
	
	public func getUserDetailsHere() {
		
		let phone = UserDefaults.standard.string(forKey: "MyPhone") ?? ""
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/profile/\(phone)/") else {
			return
		}
		
		let request = URLRequest(url: url)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(UserDetailsDataClass.self, from: data) {
					
					DispatchQueue.main.async {
						self.userDeetsHere = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	public func editProfileDp(imageToUpload: URL) {
		
//		let phone = UserDefaults.standard.string(forKey: "MyPhone") ?? ""
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/profile-update/\(userDeetsHere.id)/") else {
			return
		}
		
		var request = URLRequest(url: url)
		
		let payload = ["bio": "", "image": imageToUpload.absoluteString] as [String : Any]
		
		request.httpMethod = "PUT"
		
		do {
			request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
		} catch let error {
			print(error.localizedDescription)
		}
		
		
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let data = data {
				if let decodedResponse = try? JSONDecoder().decode(UserDetailsDataClass.self, from: data) {
					
					DispatchQueue.main.async {
						self.userDeetsHere = decodedResponse
					}
					return
				}
				
				print("debuglogs Fetch failed change dp: \(error?.localizedDescription ?? "Unknown error")")
			}
			
		}.resume()
	}
	
	
	public func editProfileDp2(imageToUpload: URL) {
		
		var semaphore = DispatchSemaphore (value: 0)
		
		let parameters = [
			[
				"key": "bio",
				"value": "\"\"",
				"type": "text"
			],
			[
				"key": "image",
				"src": imageToUpload.absoluteString,
				"type": "file"
			]] as [[String : Any]]
		
		let boundary = "Boundary-\(UUID().uuidString)"
		
		var body = ""
		
		var error: Error? = nil
		
		for param in parameters {
			
			if param["disabled"] == nil {
				
				let paramName = param["key"]!
				
				body += "--\(boundary)\r\n"
				body += "Content-Disposition:form-data; name=\"\(paramName)\""
				
				if param["contentType"] != nil {
					body += "\r\nContent-Type: \(param["contentType"] as! String)"
				}
				
				let paramType = param["type"] as! String
				
				if paramType == "text" {
				
					let paramValue = param["value"] as! String
					body += "\r\n\r\n\(paramValue)\r\n"
					
				} else {
					
					let paramSrc = param["src"] as! String
					
					var fileData: Data?
					var fileContent: String?
					
					do {
						
						fileData = try NSData(contentsOfFile: paramSrc, options:[]) as Data
						
						fileContent = String(data: fileData!, encoding: .utf8)!
						
					} catch {
						
						print("error while making file to data uploadable")
					}
					
					body += "; filename=\"\(paramSrc)\"\r\n"
						+ "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
				}
			}
		}
		
		body += "--\(boundary)--\r\n";
		
		
//		var body2 = Data()
//
//		if let fileData = paramSrc.pngData() {
//			body2.append("; filename=\"blah.png\"\r\n".data(using: .utf8)!)
//			body2.append("Content-Type: \"content-type header\"\r\n\r\n".data(using: .utf8)!)
//			body2.append(fileData)
//			body2.append()
//		}
		
		let postData = body.data(using: .utf8)
		
		var request = URLRequest(url: URL(string: "https://apisayepirates.life/api/users/profile-update/84/")!, timeoutInterval: Double.infinity)
		
		request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		
		request.httpMethod = "PUT"
		request.httpBody = postData
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				print(String(describing: error))
				semaphore.signal()
				return
			}
			print(String(data: data, encoding: .utf8)!)
			semaphore.signal()
		}
		
		task.resume()
		semaphore.wait()

	}
	
}
