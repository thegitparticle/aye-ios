//
//  EditProfileScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import SwiftUI
import Kingfisher
import ImagePickerView

struct EditProfileScreen: View {
	
	var dpLink: String
	var changeCurrentShowingView: () -> ()
	
	@StateObject private var viewModel = MyProfileViewModel()
	
	@State var showCraftView: Bool = false
	@State var showCraftViewPickedImage: Bool = false
	
	@State var showImagePicker: Bool = false
	@State var imageSelectedFromDevice: UIImage?
	@State var imageSelectedFromDeviceUrl: URL?
	
	var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
				VStack (alignment: .center) {
					
					IconButtonForOptions(title: "Edit Profile", iconName: .ios_brush, size: 20, color: LightTheme.Colors.sucesss, sfsymboliconcheck: false, sfsymbolicon: "")
					
					Spacer().frame(height: 50)
					
					if ((self.imageSelectedFromDevice) != nil) {
						
						Image(uiImage: self.imageSelectedFromDevice!).resizable().cornerRadius(22.5).frame(width: 55, height: 55).cornerRadius(50.0).onPress {
							
							self.showImagePicker = true
						}
						
					} else {
						
						KFImage.url(URL(string: self.dpLink)).resizable().cornerRadius(22.5).frame(width: 55, height: 55).cornerRadius(50.0).onPress {
							
							self.showImagePicker = true
						}
						
					}
					
					Spacer().frame(height: 50)
					
					ZStack {
						
						RoundedRectangle(cornerRadius: 30, style: .continuous)
							.fill(LightTheme.Colors.sucesss)
							.frame(width: 150, height: 60)
						
						Text("save").foregroundColor(LightTheme.Colors.uiBackground).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
						
					}.onPress {
						
//						viewModel.editProfileDp2(imageToUpload: self.imageSelectedFromDeviceUrl!, imageToUploadPngData: self.imageSelectedFromDevice ?? UIImage(imageLiteralResourceName: ""))
						
						viewModel.editProfileDp3(imageToUploadPngData: self.imageSelectedFromDevice ?? UIImage(imageLiteralResourceName: ""))
						
//						viewModel.editProfileDp(imageToUpload: self.imageSelectedFromDevice ?? UIImage(imageLiteralResourceName: ""))
					}
					
				}.frame(width: UIScreen.screenWidth)
				
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(LightTheme.Colors.uiBackground)
			
			
			HeaderHere
			
		}.navigationBarHidden(true).background(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all).sheet(isPresented: self.$showImagePicker) {
			
			ImagePickerView(sourceType: .photoLibrary) { image in
				
				self.showCraftViewPickedImage = true
				self.showCraftView = true
				self.imageSelectedFromDevice = image
				
				let filename = getDocumentsDirectory().appendingPathComponent("uploadimage.jpeg")
				try? image.jpegData(compressionQuality: CGFloat(0.5))?.write(to: filename)
				
				self.imageSelectedFromDeviceUrl = filename
				
				print ("cameradebug", image)
			}
		}
		
	}
	
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	var HeaderHere: some View {
		
		ZStack {
			
			Rectangle().fill(LightTheme.Colors.uiBackground).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(LightTheme.Colors.uiBackground)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.changeCurrentShowingView()
					}
					
					Spacer()
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
}

