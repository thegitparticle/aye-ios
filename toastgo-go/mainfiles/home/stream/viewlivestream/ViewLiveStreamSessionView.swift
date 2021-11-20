//
//  ViewLiveStreamSessionView.swift
//  toastgo-go
//
//  Created by SAN on 10/25/21.
//

import Foundation
import SwiftUI

struct ViewLiveStreamSessionView : View {
	var backColor: Color?
	var backImage: Image?
	var hideCanvas: Bool = false
	var canvas: ViewLiveStreamVideoCanvas?
	
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
