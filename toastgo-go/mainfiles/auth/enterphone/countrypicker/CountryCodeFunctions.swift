//
//  CountryCodeFunctions.swift
//  toastgo-go
//
//  Created by SAN on 10/13/21.
//

import Foundation

func countryName(countryCode: String) -> String? {
	let current = Locale(identifier: "en_US")
	return current.localizedString(forRegionCode: countryCode)
}

func flag(country:String) -> String {
	let base : UInt32 = 127397
	var flag = ""
	for v in country.unicodeScalars {
		flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
	}
	return flag
}
