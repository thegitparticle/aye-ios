//
//  MyProfileViewModel.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import SwiftUI
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
	
	public func editProfileDp(imageToUpload: UIImage) {
		
//		let phone = UserDefaults.standard.string(forKey: "MyPhone") ?? ""
		
		guard let url = URL(string: "https://apisayepirates.life/api/users/profile-update/\(userDeetsHere.id)/") else {
			return
		}
		
		var request = URLRequest(url: url)
		
		let payload = ["bio": "", "image": imageToUpload.pngData()!] as [String : Any]
		
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
	
	
	public func editProfileDp2(imageToUpload: URL, imageToUploadPngData: UIImage) {
		
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
					
//					let paramSrc = param["src"] as! String
					let paramSrc = "galgal1.jpeg"
					
					var fileData: Data?
					var fileContent: String?
					
					
					do {
						
//						do {

						fileData = try NSData(contentsOfFile: param["src"] as! String, options:[]) as Data

//						} catch {
//
//							print("error while fileData")
//						}
//
//						fileData = imageToUploadPngData.jpegData(compressionQuality: CGFloat(0.5))
						
						
							
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
	
	public func editProfileDp3(imageToUploadPngData: UIImage) {
		
		// the image in UIImage type
		let image = imageToUploadPngData
		
		let filename = "uploadimage.jpeg"
		
		// generate boundary string using a unique per-app string
		let boundary = UUID().uuidString
		
		let fieldName = "bio"
		let fieldValue = ""
		
		let config = URLSessionConfiguration.default
		let session = URLSession(configuration: config)
		
		// Set the URLRequest to POST and to the specified URL
		var urlRequest = URLRequest(url: URL(string: "https://apisayepirates.life/api/users/profile-update/84/")!)
		urlRequest.httpMethod = "PUT"
		
		// Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
		// And the boundary is also set here
		urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		
		var data = Data()
		
		// Add the reqtype field and its value to the raw http request data
		data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
		data.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n".data(using: .utf8)!)
		data.append("\(fieldValue)".data(using: .utf8)!)
		
		// Add the image data to the raw http request data
		data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
		data.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
		data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
		data.append(image.jpegData(compressionQuality: CGFloat(0.5))!)
		
		// End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
		// According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
		data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
		
		// Send a POST request to the URL, with the data we created earlier
		session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
			
			if(error != nil){
				print("\(error!.localizedDescription)")
			}
			
			guard let responseData = responseData else {
				print("no response data")
				return
			}
			
			if let responseString = String(data: responseData, encoding: .utf8) {
				print("uploaded to: \(responseString)")
			}
		}).resume()
		
	}
	
}
