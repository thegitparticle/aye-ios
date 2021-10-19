//
//  TypeInputComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/19/21.
//

import SwiftUI

struct TypeInputComponent: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TypeInputComponent_Previews: PreviewProvider {
    static var previews: some View {
        TypeInputComponent()
    }
}


//private func sendPubnubCameraMessage (imageFileHere: UIImage) {
//
//	let config = PubNubConfiguration(
//		publishKey: "pub-c-a65bb691-5b8a-4c4b-aef5-e2a26677122d",
//		subscribeKey: "sub-c-d099e214-9bcf-11eb-9adf-f2e9c1644994",
//		uuid: String(my_id)
//	)
//
//	let pubnub = PubNub(configuration: config)
//
//	let metaHere = MetaDataCMessage(type: "c", user_dp: UserDefaults.standard.string(forKey: "MyDp") ?? "")
//
//	let dataOfImage = imageFileHere.pngData()!
//
//	let customData = PubNub.PublishFileRequest(additionalMessage: "", store: true, meta: metaHere)
//
//	pubnub.send(
//
//		.data(dataOfImage, contentType: "png"),
//
//		channel: channelId,
//
//		remoteFilename: "galgalgal",
//
//		publishRequest: customData
//
//	) {
//		
//		(fileTask: HTTPFileUploadTask) in
//
//	} completion: { result in
//
//		switch result {
//
//		case let .success((task, newFile, publishedAt)):
//
//			print("The file with an ID of \(newFile.fileId) was uploaded at \(publishedAt) timetoken) ")
//
//		case let .failure(error):
//			print("An error occurred while uploading the file: \(error.localizedDescription)")
//		}
//	}
//
//}
