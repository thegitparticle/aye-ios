//
//  CamStreamSessionView.swift
//  toastgo-go
//
//  Created by SAN on 10/21/21.
//

import Foundation
import SwiftUI

struct CamStreamSessionView : View {
	var backColor: Color?
	var backImage: Image?
	var hideCanvas: Bool = false
	var canvas: CamStreamVideoCanvas?
	
	var body: some View {
		
		ZStack {
			
			if hideCanvas {
				
				backColor
				backImage
				
			} else {
				
				canvas
			}
		}
	}
}

//struct CamStreamSessionView_Previews : PreviewProvider {
//	static var previews: some View {
//		Group {
//			VideoSessionView(
//				backColor: Color("remoteBackColor"),
//				backImage: Image("big_logo"),
//				hideCanvas: true
//			)
//			VideoSessionView(
//				backColor: Color("localBackColor"),
//				backImage: Image("logo"),
//				hideCanvas: true
//			)
//			VideoSessionView(
//				hideCanvas: false
//			)
//		}
//	}
//}
