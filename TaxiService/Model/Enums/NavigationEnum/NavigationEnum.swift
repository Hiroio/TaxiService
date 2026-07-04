//
//  NavigationEnum.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import Foundation


enum ActiveSheetState{
  case search, payment, driver
  
  
  var menuIcon: String{
	 switch self {
	 case .search:
		"xmark"
	 case .payment:
		"chevron.left"
	 case .driver:
		"chevron.left"
	 }
  }
}
