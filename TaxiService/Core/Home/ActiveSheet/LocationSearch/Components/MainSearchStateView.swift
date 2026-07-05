//
//  MainSearchStateView.swift
//  TaxiService
//
//  Created by user on 05.07.2026.
//

import SwiftUI

struct MainSearchStateView: View {
  @EnvironmentObject var viewModel: LocationSearchViewModel
  let nameSpace: Namespace.ID
  var body: some View {
	 VStack(alignment: .leading, spacing: 0){
		Button{
		  withAnimation(){
			 viewModel.searchState = .userLocation
			 viewModel.panelState = .expanded
		  }
		}label: {
		  LocationSearchActivationView(searchState: .userLocation, locationText: viewModel.userLocation)
		}
		  .matchedGeometryEffect(id: SearchState.userLocation.geometryId, in: nameSpace)
		
		
		Rectangle()
		  .frame(width: 1, height: 25)
		  .padding(.leading, 9)
		
		Button{
		  withAnimation(){
			 viewModel.searchState = .destination
			 viewModel.panelState = .expanded
		  }
		}label: {
		  LocationSearchActivationView(searchState: .destination, locationText: viewModel.destinationLocation)
		}
		  .matchedGeometryEffect(id: SearchState.destination.geometryId, in: nameSpace)
	 }
  }
}

#Preview {
  @Previewable @Namespace var nameSpace
  MainSearchStateView(nameSpace: nameSpace)
	 .environmentObject(LocationSearchViewModel())
}
