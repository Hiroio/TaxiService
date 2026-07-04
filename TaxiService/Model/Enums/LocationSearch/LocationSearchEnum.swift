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
		return geoHeight / 3.5
	 }
  }
}
