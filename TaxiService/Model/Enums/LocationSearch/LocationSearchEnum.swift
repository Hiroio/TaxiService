//
//  LocationSearchEnum.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import Foundation

enum PanelState {
  case expanded
  case original
  case collapsed
  
  func height(geoHeight: CGFloat) -> CGFloat {
	 switch self {
	 case .expanded:
		return geoHeight / 1.5
	 case .original:
		return geoHeight / 2
	 case .collapsed:
		return geoHeight / 4
	 }
  }
}



enum SearchState {
  case main, userLocation, destination
  
  var textfieldText: String {
	 switch self {
	 case .main:
		""
	 case .userLocation:
		"Where you at"
	 case .destination:
		"Where you heading"
	 }
  }
  
  
  var icon: String {
	 switch self {
	 case .main:
		""
	 case .userLocation:
		"person.bust.fill"
	 case .destination:
		"signpost.right.and.left.fill"
	 }
  }
  
  
  var geometryId: String{
	 switch self {
	 case .main:
		""
	 case .userLocation:
		"userLocationId"
	 case .destination:
		"DestinationId"
	 }
  }
  
  static var userLocationIcon: String{
	 "person.bust.fill"
  }
  static var destinationLocationIcon: String{
	 "signpost.right.and.left.fill"
  }
}



enum LocationSearchState{
  case text, map
}
