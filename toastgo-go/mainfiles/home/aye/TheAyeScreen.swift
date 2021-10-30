//
//  TheAyeScreen.swift
//  toastgo-go
//
//  Created by SAN on 10/25/21.
//

import SwiftUI
import HighlightedTextEditor

//let betweenUnderscores = try! NSRegularExpression(pattern: "_[^_]+_", options: [])

struct TheAyeScreen: View {
	
	@Environment(\.presentationMode) var mode: Binding<PresentationMode>
	
	@State private var text: String = ""
	
	@State private var selectedText = ""
	
//	private let rules: [HighlightRule] = [
//		HighlightRule(pattern: betweenUnderscores, formattingRules: [
//			TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
//			TextFormattingRule(key: .foregroundColor, value: UIColor.red),
//			TextFormattingRule(key: .underlineStyle) { content, range in
//				if content.count > 10 { return NSUnderlineStyle.double.rawValue }
//				else { return NSUnderlineStyle.single.rawValue }
//			}
//		])
//	]
	
    var body: some View {
		
		ZStack(alignment: .top) {
			
			VStack(alignment: .center) {
				
//				HighlightedTextEditor(text: $text, highlightRules: rules)
//					// optional modifiers
//					.onCommit { print("commited") }
//					.onEditingChanged { print("editing changed") }
//					.onTextChange { print("latest text value", $0) }
//					.onSelectionChange { (range: NSRange) in
//
//						print(self.text.dropFirst(range.lowerBound).prefix(range.upperBound - range.lowerBound) as Substring)
//
//					}
//					.introspect { editor in
//						// access underlying UITextView or NSTextView
//						editor.textView.backgroundColor = UIColor(LightTheme.Colors.uiSurface)
//						editor.textView.font = UIFont(name: "GothamRounded-Book", size: 15)
//						editor.textView.textColor = UIColor(LightTheme.Colors.textPrimary)
//
//					}.frame(width: .infinity, height: 30).padding().font(LightTheme.Typography.body2).background(LightTheme.Colors.uiSurface).cornerRadius(10)
				
				Image("sup_transparent")
					.resizable()
					.aspectRatio(contentMode: .fit)
				
				
				ZStack(alignment: .center) {
					
					HStack(alignment: .center) {
						
						Spacer()
						
						Text("talk to founder").foregroundColor(LightTheme.Colors.textPrimary).font(LightTheme.Typography.subtitle1).padding(.horizontal, 10).padding(.vertical, 1)
						
						Spacer()
						
					}
					
				}.background(Color.gray).frame(width: UIScreen.screenWidth * 0.7, height: 50).cornerRadius(10)
				
			}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).padding(.top, 100).background(Color.black)
			
			HeaderHere
			
		}.navigationBarHidden(true).background(Color.black).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
		
    }
	
	var HeaderHere: some View {
		
		ZStack {
			
			Rectangle().fill(Color.black).frame(maxWidth: .infinity, maxHeight: 100, alignment: .top).background(Color.black)
			
			VStack (alignment: .center) {
				
				Spacer(minLength: statusBarHeight)
				
				HStack () {
					
					HStack {
						
						CircleIcon(size: 13, iconName: .ios_close).padding(.horizontal, 20)
						
					}.onPress {
						
						self.mode.wrappedValue.dismiss()
					}
					
					Spacer()
					
				}.padding(.bottom, 5)
				
			}.frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
		}
		
	}
}

struct TheAyeScreen_Previews: PreviewProvider {
    static var previews: some View {
        TheAyeScreen()
    }
}
