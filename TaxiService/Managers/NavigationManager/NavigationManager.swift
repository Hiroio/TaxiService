//
//  NavigationManager.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import Foundation
import Combine

class NavigationManager: ObservableObject{
  static let shared = NavigationManager()
  
  @Published var sheetState: ActiveSheetState? = nil
}
