//
//  TalkCameraScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/17/21.
//

import SwiftUI
import SwiftUICam
import SwiftUIFontIcon
import Camera_SwiftUI
import ImagePickerView
import PubNub

struct TalkCameraScreen: View {
	
	@ObservedObject var events = UserEvents()
	@ObservedObject var pubnubSetUpHere = PubnubSetup()
	
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	var clubName: String     // in directs, its the other user's name
	var clubId: Int 			// in directs, its the other user's id
	var channelId: String
	var ongoingFrame: Bool
	var startTime: String
	var endTime: String
	var ongoingStream: Bool
	var ongoingStreamUser: String
	var directornot: Bool
	
	var my_id: Int
	var my_name: String
	
	@StateObject var model = TalkCameraViewModel()
	
	@State var currentZoomFactor: CGFloat = 1.0
	
	@State var showCraftView: Bool = false
	@State var showCraftViewPickedImage: Bool = false
	
	@State var showImagePicker: Bool = false
	@State var imageSelectedFromDevice: UIImage?
	
	var body: some View {
		
		GeometryReader { reader in
			
			ZStack {
				
				if (!showCraftView) {
				
				VStack {
					
					topButtons
					
					CameraPreview(session: model.session)
						.gesture(
							DragGesture().onChanged({ (val) in
								//  Only accept vertical drag
								if abs(val.translation.height) > abs(val.translation.width) {
									//  Get the percentage of vertical screen space covered by drag
									let percentage: CGFloat = -(val.translation.height / reader.size.height)
									//  Calculate new zoom factor
									let calc = currentZoomFactor + percentage
									//  Limit zoom factor to a maximum of 5x and a minimum of 1x
									let zoomFactor: CGFloat = min(max(calc, 1), 5)
									//  Store the newly calculated zoom factor
									currentZoomFactor = zoomFactor
									//  Sets the zoom factor to the capture device session
									model.zoom(with: zoomFactor)
								}
							})
						).onAppear {
							model.configure()
						}
						.animation(.easeInOut)
					
					captureButton
					
					bottomButtons
					
				}.sheet(isPresented: self.$showImagePicker) {
					ImagePickerView(sourceType: .photoLibrary) { image in
						self.showCraftViewPickedImage = true
						self.showCraftView = true
						self.imageSelectedFromDevice = image
						print ("cameradebug", image)
					}
				}
					
				} else {
					
					if (!showCraftViewPickedImage) {
					
						craftView
						
					} else {
						
						craftViewPickedFromDevice
					}
					
				}
				
				
			}.navigationBarHidden(true).background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
			
		}
		
	}
	
	private func sendPubnubCameraMessage (imageFileHere: UIImage) {
		
		let metaHere = MetaDataCMessage(type: "c", user_dp: UserDefaults.standard.string(forKey: "MyDp") ?? "")
		
		let dataOfImage = imageFileHere.pngData()!
		
		let customData = PubNub.PublishFileRequest(additionalMessage: "", store: true, meta: metaHere)
		
		pubnubSetUpHere.pubnub.send(

			.data(dataOfImage, contentType: "png"),
			
			channel: channelId,

			remoteFilename: "galgalgal",
			
			publishRequest: customData

		) {
			
			(fileTask: HTTPFileUploadTask) in
			
		} completion: { result in
			
			switch result {
			
			case let .success((task, newFile, publishedAt)):

				print("The file with an ID of \(newFile.fileId) was uploaded at \(publishedAt) timetoken) ")

			case let .failure(error):
				print("An error occurred while uploading the file: \(error.localizedDescription)")
			}
		}
		
	}
	
	var captureButton: some View {
		
		HStack {
			
			ZStack {
				Button(action: {
					model.capturePhoto();
					self.showCraftViewPickedImage = false
					self.showCraftView = true
				}, label: {
					Circle()
						.foregroundColor(.white)
						.frame(width: 80, height: 80, alignment: .center)
						.overlay(
							Circle()
								.stroke(Color.black.opacity(0.8), lineWidth: 2)
								.frame(width: 65, height: 65, alignment: .center)
						)
				})
				
			}.padding(.vertical, 30)
		}
	}
	
	var topButtons: some View {
		
		HStack {
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				FontIcon.text(.materialIcon(code: .close), fontsize: 35).foregroundColor(Color.white)
				
			}.padding(.horizontal, 10).onTapGesture {
				
				model.destroyCamera()
				
				self.mode.wrappedValue.dismiss()
			}
			
			Spacer ()
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				if (model.isFlashOn) {
					
					FontIcon.text(.ionicon(code: .ios_flash), fontsize: 35).foregroundColor(Color.white)
					
				} else {
					
					FontIcon.text(.ionicon(code: .ios_flash_off), fontsize: 35).foregroundColor(Color.white)
				}
				
			}.padding(.horizontal, 10).onTapGesture {
				model.switchFlash()
			}
			
		}.padding(.top, 20)
	}
	
	var bottomButtons: some View {
		
		HStack {
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_images), fontsize: 35).foregroundColor(Color.white)
				
			}.padding(.horizontal, 10).onTapGesture {
				
				self.showImagePicker = true
			}
			
			Spacer()
			
			ZStack {
				
				Circle().frame(width: 20, height: 20)
					.padding()
					.foregroundColor(Color.black.opacity(0.25))
					.background(Color.black.opacity(0.25))
					.cornerRadius(70)
				
				FontIcon.text(.ionicon(code: .ios_reverse_camera), fontsize: 35).foregroundColor(Color.white)
				
			}.padding(.horizontal, 10).onTapGesture {
				model.flipCamera()
			}
			
		}.padding(.bottom, 20)
	}
	
	var craftView: some View {
		
		VStack {
			if (model.photoClicked != nil ) {
				
				Image(uiImage: model.photoClicked.image ?? UIImage(imageLiteralResourceName: "")).resizable().aspectRatio(contentMode: .fit).animation(.spring())
			
			HStack {
				
				ZStack {
					
					Circle().frame(width: 20, height: 20)
						.padding()
						.foregroundColor(Color.white.opacity(0.75))
						.background(Color.white.opacity(0.75))
						.cornerRadius(70)
					
					FontIcon.text(.ionicon(code: .ios_backspace), fontsize: 35).foregroundColor(Color.black)
					
				}.padding(.horizontal, 10).onTapGesture {
					self.showCraftView = false
				}
				
				Spacer()
				
				ZStack {
					
					RoundedRectangle(cornerRadius: 10).frame(width: 60, height: 40)
						.padding()
						.foregroundColor(Color.white.opacity(0.75))
						.background(Color.white.opacity(0.75))
					
					Text("send").foregroundColor(Color.black).font(LightTheme.Typography.subtitle2).padding(.horizontal, 10).padding(.vertical, 3)
					
				}.padding(.horizontal, 10).onTapGesture {
					// send to pubnub logic
					sendPubnubCameraMessage(imageFileHere: model.photoClicked.image ?? UIImage(imageLiteralResourceName: ""))
				}
				
			}.padding(.bottom, 20).background(Color.black)
				
		}
			
		}.background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity)
	}
	
	var craftViewPickedFromDevice: some View {
		
		VStack {
				
			Image(uiImage: self.imageSelectedFromDevice ?? UIImage(imageLiteralResourceName: "")).resizable().aspectRatio(contentMode: .fit).animation(.spring())
				
				HStack {
					
					ZStack {
						
						Circle().frame(width: 20, height: 20)
							.padding()
							.foregroundColor(Color.white.opacity(0.75))
							.background(Color.white.opacity(0.75))
							.cornerRadius(70)
						
						FontIcon.text(.ionicon(code: .ios_backspace), fontsize: 35).foregroundColor(Color.black)
						
					}.padding(.horizontal, 10).onTapGesture {
						self.showCraftViewPickedImage = false
						self.showCraftView = false
					}
					
					Spacer()
					
					ZStack {
						
						RoundedRectangle(cornerRadius: 10).frame(width: 60, height: 40)
							.padding()
							.foregroundColor(Color.white.opacity(0.75))
							.background(Color.white.opacity(0.75))
						
						Text("send").foregroundColor(Color.black).font(LightTheme.Typography.subtitle2).padding(.horizontal, 10).padding(.vertical, 3)
						
					}.padding(.horizontal, 10).onTapGesture {
						// send to pubnub logic
						sendPubnubCameraMessage(imageFileHere: self.imageSelectedFromDevice ?? UIImage(imageLiteralResourceName: ""))
					}
					
				}.padding(.bottom, 20).background(Color.black)
				
			
		}.background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity)
	}
	
}

struct TalkCameraScreen_Previews: PreviewProvider {
	static var previews: some View {
		TalkCameraScreen(clubName: "", clubId: 0, channelId: "", ongoingFrame: false, startTime: "", endTime: "", ongoingStream: false, ongoingStreamUser: "", directornot: false, my_id: 82, my_name: "San")
	}
}
