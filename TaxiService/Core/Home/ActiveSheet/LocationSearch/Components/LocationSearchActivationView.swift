//
//  LocationSearchActivationView.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct LocationSearchActivationView: View {
  let searchState: SearchState
  let locationText: String?
  init(searchState: SearchState = SearchState.destination, locationText: String? = nil){
	 self.searchState = searchState
	 self.locationText = locationText
  }
    var body: some View {
		HStack(){
		  Image(systemName: searchState.icon)
			 .padding(.leading, 10)
		  
		  Rectangle()
			 .frame(width: 1)
			 .padding(.horizontal, 5)
		  
		  
		  Text(locationText ?? searchState.textfieldText)
			 .font(.headline.weight(.medium))
		}
		.foregroundStyle(.secondary)
		.frame(height: 55)
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(
		  .white,
		  in: .rect(cornerRadius: 25)
		)
		.background(
		  Color.black,
		  in: .rect(cornerRadius: 25).stroke(lineWidth: 1)
		)
    }
}

#Preview {
    LocationSearchActivationView()
}
