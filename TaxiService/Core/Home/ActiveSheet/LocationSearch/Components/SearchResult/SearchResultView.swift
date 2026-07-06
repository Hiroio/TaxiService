//
//  SearchResultView.swift
//  TaxiService
//
//  Created by user on 06.07.2026.
//

import SwiftUI

struct SearchResultView: View {
  @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
		switch viewModel.searchState {
		case .main:
		  Text("Start your trip")
		case .userLocation, .destination:
		  TexfieldResult()
		}
    }
}

#Preview {
    SearchResultView()
	 .environmentObject(LocationSearchViewModel())
}
