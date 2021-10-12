//
//  CountryPickerCustom.swift
//  toastgo-go
//
//  Created by SAN on 10/13/21.
//
//
//import Foundation
//import CountryPicker
//
//struct CountryPickerCustom: UIViewController, CountryPickerDelegate {
//
//	@IBOutlet weak var picker: CountryPicker?
//	var code: String?
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		//get current country
//		let locale = Locale.current
//		let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
//		//init Picker
//		picker?.displayOnlyCountriesWithCodes = ["DK", "SE", "NO", "DE"] //display only
//		picker?.exeptCountriesWithCodes = ["RU"] //exept country
//		let theme = CountryViewTheme(countryCodeTextColor: .white, countryNameTextColor: .white, rowBackgroundColor: .black, showFlagsBorder: false)        //optional for UIPickerView theme changes
//		picker?.theme = theme //optional for UIPickerView theme changes
//		picker?.countryPickerDelegate = self
//		picker?.showPhoneNumbers = true
//		picker?.setCountry(code!)
//
//	}
//
//	// a picker item was selected
//	func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
//		//pick up anythink
//		code = phoneCode
//	}
//}
