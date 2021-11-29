//
//  IconButtonForOptions.swift
//  toastgo-go
//
//  Created by SAN on 10/24/21.
//

import SwiftUI
import SwiftUIFontIcon

struct IconButtonForOptions: View {
	
	var title: String
	var iconName: IonIconsCode
	var size: Int
	var color: Color
	var sfsymboliconcheck: Bool
	var sfsymbolicon: String
	
	var body: some View {
		
		ZStack {
			
			HStack {
				
				HStack {
					
					if (sfsymboliconcheck) {
						
						SquareIconSFSymbol
						
					} else {
						
						SquareIcon
						
					}
					
					Text(self.title).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
					
				}
				
				Spacer()
				
			}
			
			
		}.background(LightTheme.Colors.uiSurface).frame(width: UIScreen.screenWidth * 0.9, height: 50).cornerRadius(10)
		
	}
	
	var SquareIcon: some View {
		
		ZStack {
			
			Circle().frame(width: CGFloat(self.size * 2), height: CGFloat(self.size * 2))
				.padding()
				.foregroundColor(color.opacity(0.15))
				.cornerRadius(CGFloat(self.size))
			
			FontIcon.text(.ionicon(code: self.iconName), fontsize: CGFloat(self.size)).foregroundColor(color)
			
		}
	}
	
	var SquareIconSFSymbol: some View {
		
		ZStack {
			
			Circle().frame(width: CGFloat(self.size * 2), height: CGFloat(self.size * 2))
				.padding()
				.foregroundColor(color.opacity(0.15))
				.cornerRadius(CGFloat(self.size))
			
			Image(systemName: self.sfsymbolicon).font(LightTheme.Typography.body2).foregroundColor(LightTheme.Colors.iconVector)
			
		}
	}
	
}

struct IconButtonForOptionsWithInfo: View {
	
	var title: String
	var info: String
	var iconName: IonIconsCode
	var size: Int
	var color: Color
	var sfsymboliconcheck: Bool
	var sfsymbolicon: String
	
	var body: some View {
		
		ZStack {
			
			HStack {
				
				HStack {
					
					if (sfsymboliconcheck) {
						
						SquareIconSFSymbol
						
					} else {
					
						SquareIcon
						
					}
					
					Text(self.title).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
					
				}
				
				Spacer()
				
				Text(self.info).foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.body1).padding(.horizontal, 10).padding(.vertical, 1)
				
			}
			
		}.background(LightTheme.Colors.uiSurface).frame(width: UIScreen.screenWidth * 0.9, height: 50).cornerRadius(10)
		
	}
	
	var SquareIcon: some View {
		
		ZStack {
			
			Circle().frame(width: CGFloat(self.size * 2), height: CGFloat(self.size * 2))
				.padding()
				.foregroundColor(color.opacity(0.15))
				.cornerRadius(CGFloat(self.size))
			
			FontIcon.text(.ionicon(code: self.iconName), fontsize: CGFloat(self.size)).foregroundColor(color)
			
		}
	}
	
	var SquareIconSFSymbol: some View {
		
		ZStack {
			
			Circle().frame(width: CGFloat(self.size * 2), height: CGFloat(self.size * 2))
				.padding()
				.foregroundColor(color.opacity(0.15))
				.cornerRadius(CGFloat(self.size))
			
			Image(systemName: self.sfsymbolicon).font(LightTheme.Typography.body2).foregroundColor(LightTheme.Colors.iconVector)
			
		}
	}
	
}
