//
//  LocationSearchViewModel.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import Foundation
import MapKit
import Combine

class LocationSearchViewModel: NSObject, ObservableObject{
  
  //  MARK: - Properties
  
  @Published var result = [SearchResult]()
  @Published var panelState: PanelState = .original
  private let searchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()
  
  @Published var queryFragment: String = "" {
	 didSet{
		self.searchCompleter.queryFragment = queryFragment
	 }
  }
  
  var destinationLocation: String? = nil
  var userLocation: String? = nil
  
  private let rideLocationManager = RideLocationManager.shared
  private var cancellables = Set<AnyCancellable>()

  override init(){
	 super.init()
	 searchCompleter.delegate = self
	 searchCompleter.queryFragment = queryFragment

	 rideLocationManager.objectWillChange
		.sink { [weak self] _ in
		  self?.objectWillChange.send()
		}
		.store(in: &cancellables)
  }
  
  var searchState: SearchState {
	 rideLocationManager.searchState
  }
  
  var locationSearchState: LocationSearchState{
	 rideLocationManager.locationSearchState
  }
  
  var mapSearchLocationResult: String? {
	 rideLocationManager.destinationTitle?.name
  }
}
  
extension LocationSearchViewModel{
  func submitLocationSelection(_ location: SearchResult? = nil) {
	 switch locationSearchState {
	 case .text:
		guard let location else { return }
		submitTextLocation(location)
	 case .map:
		submitMapPinLocation()
	 }
  }
  
  func submitTextLocation(_ location: SearchResult){
	 searchForLocation(location.location) {[weak self] result, _ in
		guard let result, let self else { return }
		self.rideLocationManager.setDestination(result.mapItems.first)
		self.destinationLocation = location.title
		self.finishLocationSelection()
	 }
  }
  
  func submitMapPinLocation() {
	 guard let item = self.rideLocationManager.destinationTitle else { return }
	 
		self.rideLocationManager.setDestination(item)
		self.destinationLocation = item.name
		self.finishLocationSelection()
	 
  }
	  
  func searchForLocation(_ location: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
	 let searchRequest = MKLocalSearch.Request()
	 searchRequest.naturalLanguageQuery = location.title.appending(location.subtitle)
	 
	 let search = MKLocalSearch(request: searchRequest)
	 search.start(completionHandler: completion)
  }
  func changeSearchState(to state: SearchState){
	 rideLocationManager.changeSearchState(to: state)
  }
  
  func changeLocationSearchState(to state: LocationSearchState){
	 rideLocationManager.changeLocationSearchState(to: state)
  }
  
  private func finishLocationSelection() {
	 panelState = .collapsed
	 rideLocationManager.resetSearchMode()
  }
}



//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
	 result = completer.results.map({SearchResult(title: $0.title, subtitle: $0.subtitle, location: $0)})
  }
}


struct SearchResult: Identifiable{
  let id = UUID()
  let title: String
  let subtitle: String
  let location: MKLocalSearchCompletion
}
