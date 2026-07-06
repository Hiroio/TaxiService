//
//  RideLocationManager.swift
//  TaxiService
//
//  Created by user on 05.07.2026.
//

import Foundation
import CoreLocation
import MapKit
import Combine

@MainActor
final class RideLocationManager: ObservableObject {
  static let shared = RideLocationManager()
  
  @Published var searchState: SearchState = .main
  @Published var locationSearchState: LocationSearchState = .text
  
  @Published var pickupLocation: CLLocationCoordinate2D?
  @Published var destination: MKMapItem?
  @Published var destinationTitle: MKMapItem?
  @Published var route: MKRoute?
  @Published var distance: CLLocationDistance?
  @Published var price: Double?
  
  private var geocodeTask: Task<Void, Never>?
  @Published var reverseGeocodePlaceMark: MKMapItem? = nil
  
  private init() {}
}

extension RideLocationManager {
  func setDestination(_ mapItem: MKMapItem?) {
	 destination = mapItem
  }
  
  func changeSearchState(to state: SearchState) {
	 searchState = state
  }
  
  func changeLocationSearchState(to state: LocationSearchState) {
	 locationSearchState = state
  }
  
  func resetSearchMode() {
	 searchState = .main
	 locationSearchState = .text
  }
  
}


extension RideLocationManager {
  func cancelPendingGeocode() {
	 geocodeTask?.cancel()
	 geocodeTask = nil
	 destinationTitle = nil
  }

  func updateDestinationTitle(for coordinate: CLLocationCoordinate2D) {
	 print("DEBUG: UPDATING DESTINATION FOR MOVE PIN")
	 geocodeTask?.cancel()
	 geocodeTask = Task {
		try? await Task.sleep(nanoseconds: 300_000_000)
		let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
		do {
		  let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
		  guard !Task.isCancelled, let placemark = placemarks.first else { return }
		  await MainActor.run { [weak self] in
			 self?.destinationTitle = MKMapItem(placemark: MKPlacemark(placemark: placemark))
		  }
		} catch {
		  
		}
	 }
  }
}
