//
//  TexfieldResult.swift
//  TaxiService
//
//  Created by user on 06.07.2026.
//

import SwiftUI

struct TexfieldResult: View {
  @EnvironmentObject var viewModel: LocationSearchViewModel
  var body: some View {
	 let active = (viewModel.mapSearchLocationResult == nil || viewModel.mapSearchLocationResult == "")
	 switch viewModel.locationSearchState {
	 case .text:
		ScrollView{
		  LazyVStack(spacing: 10){
			 ForEach(viewModel.result) { item in
				Button{
				  viewModel.submitLocationSelection(item)
				}label:{
				  SearchComponent(title: item.title, subTitle: item.subtitle)
				}
			 }
		  }
		  .animation(.easeInOut, value: viewModel.result.count)
		  .padding()
		}
	 case .map:
		Button{
		  viewModel.submitLocationSelection()
		}label: {
		  HStack{
			 Text("Select location")
			 Image(systemName: "mappin")
				.foregroundStyle(.red)
				.accentColor(.white)
		  }
		  .font(.headline)
		  .frame(maxWidth: .infinity)
		  .padding(15)
		  .background(
			 RoundedRectangle(cornerRadius: 25)
				.fill(.green.opacity(0.6))
		  )
		  .padding(.top, 10)
		}
		.disabled(active)
		.opacity(active ? 0.6 : 1)
	 }
  }
}

#Preview {
  TexfieldResult()
	 .environmentObject(LocationSearchViewModel())
}
