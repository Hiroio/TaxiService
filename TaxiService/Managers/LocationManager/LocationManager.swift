//
//  LocationManager.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import Foundation
import CoreLocation
import Combine


class LocationManager: NSObject, ObservableObject{
  @Published var selectedLocation: String? = nil
  
  private let locationMangaer = CLLocationManager()
  
  override init(){
	 super.init()
	 locationMangaer.delegate = self
	 
	 locationMangaer.desiredAccuracy = kCLLocationAccuracyBest
	 locationMangaer.requestWhenInUseAuthorization()
	 locationMangaer.startUpdatingLocation()
  }
}


extension LocationManager: CLLocationManagerDelegate{
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
	 guard !locations.isEmpty else { return }
//	 Stopping because we want to mapkit take actions on user locations 
	 locationMangaer.stopUpdatingLocation()
  }
}
