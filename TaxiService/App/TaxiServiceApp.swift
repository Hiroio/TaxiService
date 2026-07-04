//
//  TaxiServiceApp.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

@main
struct TaxiServiceApp: App {
  @StateObject private var navigation = NavigationManager.shared
  @StateObject private var rideLocationMananger = RideLocationManager.shared
    var body: some Scene {
        WindowGroup {
            HomeView()
				.environmentObject(navigation)
				.environmentObject(rideLocationMananger)
        }
    }
}
