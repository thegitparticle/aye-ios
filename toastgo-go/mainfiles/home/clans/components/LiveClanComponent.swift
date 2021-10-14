//
//  LiveClanComponent.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import SwiftUI
import Kingfisher

struct LiveClanComponent: View {
	
	var body: some View {
		
		ScrollView {
			VStack (alignment: .center) {
				
				OneOtherPerson()
				TwoOtherPeople()
				ThreeOtherPeople()
				MoreOtherPeople()
				
			}.frame(maxWidth: .infinity).padding(20)
		}
		
	}
}

private struct OneOtherPerson: View {
	
	var body: some View {
		VStack {
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0)
			}
			TextPart()
		}
	}
}

private struct TwoOtherPeople: View {
	
	var body: some View {
		VStack(alignment: .center) {
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0).offset(x: +5)
				
				KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0).offset(x: -5)
				
			}
			TextPart()
		}
	}
}

private struct ThreeOtherPeople: View {
	
	var body: some View {
		
		VStack () {
			
			KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
				.cornerRadius(50.0).offset(y: +10)
			
			
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0).offset(x: +5)
				
				KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0).offset(x: -5)
			}.offset(y: -10)
			
			TextPart()
			
		}
	}
}

private struct MoreOtherPeople: View {
	
	var body: some View {
		
		VStack () {
			
			KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
				.cornerRadius(50.0).offset(y: +10)
			
			
			HStack (alignment: .center) {
				
				KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0).offset(x: +5)
				
				KFImage.url(URL(string: "https://aye-media-bucket.s3.amazonaws.com/media/club_images/moneyh_1.jpg")!).cornerRadius(30).frame(maxWidth: 60, maxHeight: 60).aspectRatio(100.0 / 100.0, contentMode: .fit)
					.cornerRadius(50.0).offset(x: -5)
				
			}.offset(y: -10)
			
			ZStack {
				
				Circle().frame(width: 30, height: 30)
					.padding()
					.foregroundColor(LightTheme.Colors.textSecondary)
					.background(LightTheme.Colors.textSecondary)
					.cornerRadius(70)
				
				Text("+3").foregroundColor(LightTheme.Colors.uiSurface).font(LightTheme.Typography.subtitle1)
				
			}.offset(y: -25)
			
			TextPart()
			
		}
	}
}

private struct TextPart: View {
	
	var body: some View {
		
		VStack(alignment: .center) {
			
			Text("Pope n Test").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 2)
			
			Text("live frame").foregroundColor(LightTheme.Colors.appLead).font(LightTheme.Typography.body2).padding(.horizontal, 10).padding(.vertical, 2)
		}
	}
}

struct LiveClanComponent_Previews: PreviewProvider {
	static var previews: some View {
		LiveClanComponent()
	}
}
