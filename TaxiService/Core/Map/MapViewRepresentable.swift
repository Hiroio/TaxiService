//
//  MapViewRepresentable.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import Foundation
import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable{
  @EnvironmentObject private var rideLocationManager: RideLocationManager
  @EnvironmentObject private var navigation: NavigationManager
  let mapView = MKMapView()
  let locationManager = LocationManager()
  
  func makeUIView(context: Context) -> some UIView {
	 mapView.delegate = context.coordinator
	 mapView.isRotateEnabled = false
	 mapView.showsUserLocation = true
	 mapView.userTrackingMode = .follow
	 
	 return mapView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
	 if navigation.sheetState == nil {
		context.coordinator.clearMapView()
		context.coordinator.centerUserLocation()
		return
	 }
	 
	 if let coordinate = rideLocationManager.destination?.placemark.coordinate {
		context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
		context.coordinator.configurePolyLine(with: coordinate)
	 }
  }
  
  func makeCoordinator() -> MapCoordinator {
	 return MapCoordinator(parent: self)
  }
}


extension MapViewRepresentable{
  class MapCoordinator: NSObject, MKMapViewDelegate{
	 
	 //	 MARK: - Properties
	 let parent: MapViewRepresentable
	 
	 //	 MARK: - Lifecycle
	 
	 init(parent: MapViewRepresentable) {
		self.parent = parent
		super.init()
	 }
	 
	 //	 MARK: - MKMapViewDelegate
	 
	 func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
		let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
		
		parent.mapView.setRegion(region, animated: true)
	 }
	 
	 func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
		guard parent.rideLocationManager.locationSearchState == .map && parent.navigation.sheetState != nil else { return }
		
		DispatchQueue.main.async{ [weak self] in
		  self?.parent.rideLocationManager.destinationTitle = nil
		}
	 }
	 
	 func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
		guard parent.rideLocationManager.locationSearchState == .map && parent.navigation.sheetState != nil else { return }
		
		parent.rideLocationManager.updateDestinationTitle(for: parent.mapView.region.center)
	 }
	 
	 //	 MARK: - Helpers
	 
	 func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
		self.clearMapView()
		
		let anno = MKPointAnnotation()
		anno.coordinate = coordinate
		self.parent.mapView.addAnnotation(anno)
		self.parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
		self.parent.mapView.selectAnnotation(anno, animated: true)
	 }
	 
	 func getDestinationRoute(
		from userLocation: CLLocationCoordinate2D,
		to destinationLocation: CLLocationCoordinate2D,
		completion: @escaping(MKRoute) -> Void
	 ){
		let userPlaceMark = MKPlacemark(coordinate: userLocation)
		let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
		
		let request = MKDirections.Request()
		request.source = MKMapItem(placemark: userPlaceMark)
		request.destination = MKMapItem(placemark: destinationPlaceMark)
		
		let directions = MKDirections(request: request)
		
		directions.calculate() { response, error in
		  if let error = error {
			 print("DEBUG: Failed to load direction with error: \(error.localizedDescription)")
		  } else if let route = response?.routes.first {
			 completion(route)
		  }
		}
	 }
	 
	 
	 func configurePolyLine(with destinationCoordinate: CLLocationCoordinate2D) {
		getDestinationRoute(from: parent.mapView.userLocation.coordinate, to: destinationCoordinate) { route in
		  guard self.parent.navigation.sheetState != nil else { return }
		  self.parent.mapView.addOverlay(route.polyline)
		}
	 }
	 
	 func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
		let overlay = MKPolylineRenderer(overlay: overlay)
		overlay.strokeColor = .cyan
		overlay.alpha = 0.5
		overlay.lineWidth = 6
		
		return overlay
	 }
	 
	 
	 func clearMapView(){
		let annotations = parent.mapView.annotations.filter { !($0 is MKUserLocation) }
		self.parent.mapView.removeAnnotations(annotations)
		self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
	 }
	 
	 func centerUserLocation(){
		self.parent.mapView.setCenter(self.parent.mapView.userLocation.coordinate, animated: true)
	 }
  }
}
