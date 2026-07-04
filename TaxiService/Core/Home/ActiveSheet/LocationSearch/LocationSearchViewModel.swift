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
  
  var queryFragment: String = "" {
	 didSet{
		self.searchCompleter.queryFragment = queryFragment
	 }
  }
  
  private let rideLocationManager = RideLocationManager.shared
  
  override init(){
	 super.init()
	 searchCompleter.delegate = self
	 searchCompleter.queryFragment = queryFragment
  }
  
  func selectLocation(_ location: SearchResult){
	 searchForLocation(location.location) {[weak self] result, _ in
		guard let result, let self else { return }
		self.rideLocationManager.destination = result.mapItems.first
		self.panelState = .collapsed
	 }
  }
  
  func searchForLocation(_ location: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
	 let searchRequest = MKLocalSearch.Request()
	 searchRequest.naturalLanguageQuery = location.title.appending(location.subtitle)
	 
	 let search = MKLocalSearch(request: searchRequest)
	 search.start(completionHandler: completion)
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
