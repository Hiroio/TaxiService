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
  
  @Published var result = [MKLocalSearchCompletion]()
  private let searchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()
  var queryFragment: String = "" {
	 didSet{
		self.searchCompleter.queryFragment = queryFragment
	 }
  }
  
  override init(){
	 super.init()
	 searchCompleter.delegate = self
	 searchCompleter.queryFragment = queryFragment
  }
  
  
  
}



//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
	 result = completer.results
  }
}
