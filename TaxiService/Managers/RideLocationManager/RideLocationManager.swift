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

final class RideLocationManager: ObservableObject {
  static let shared = RideLocationManager()
  
  @Published var mapState: MapState = .noInput
  
  @Published var pickupLocation: CLLocationCoordinate2D?
  @Published var destination: MKMapItem?
  @Published var destinationTitle: MKMapItem?
  @Published var route: MKRoute?
  @Published var distance: CLLocationDistance?
  @Published var price: Double?
  
  private init() {}
}
