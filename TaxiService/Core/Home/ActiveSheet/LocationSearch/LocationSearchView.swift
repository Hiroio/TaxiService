//
//  LocationSearchView.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct LocationSearchView: View {
  let nameSpace: Namespace.ID
  let panelState: PanelState
  @EnvironmentObject var viewModel: LocationSearchViewModel
  @State private var userLocation: String = ""
  var body: some View {
	 VStack(){
		
		Group{
		  switch viewModel.searchState {
		  case .main:
			 MainSearchStateView(nameSpace: nameSpace)
		  case .userLocation, .destination:
			 SearchTextField(nameSpace: nameSpace, searchState: viewModel.searchState)
		  }
		}
		.padding(.top)
		if panelState == .collapsed {
		  EmptyView()
		}else if viewModel.result.isEmpty{
		  Spacer()
		  Text("qwerty")
		  Spacer()
		}else{
		  ScrollView{
			 LazyVStack(spacing: 10){
				ForEach(viewModel.result) { item in
				  Button{
					 viewModel.selectLocation(item)
				  }label:{
					 SearchComponent(title: item.title, subTitle: item.subtitle)
				  }
				}
			 }
			 .animation(.easeInOut, value: viewModel.result.count)
			 .padding()
		  }
		}
	 }
  }
}

#Preview {
  @Previewable @Namespace var nameSpace
  LocationSearchView(nameSpace: nameSpace, panelState: .original, viewModel: .init())
	 .environmentObject(LocationSearchViewModel())
}


extension LocationSearchView{
  func searchTextField(searchState: SearchState, nameSpace: Namespace.ID) -> some View{
	 HStack(spacing: 0){
		Image(systemName: searchState.icon)
		  .padding(.leading, 10)
		
		Rectangle()
		  .frame(width: 2)
		  .padding(.leading, 5)
		TextField("", text: $viewModel.queryFragment, prompt: Text(searchState.textfieldText))
		  .padding(.leading, 10)
		  .frame(height: 55)
		  .background(
			 UnevenRoundedRectangle(cornerRadii: .init(topLeading: 10, bottomLeading: 10, bottomTrailing: 25, topTrailing: 25))
				.fill(.black.opacity(0.05))
		  )
	 }
	 .matchedGeometryEffect(id: searchState.geometryId, in: nameSpace)
	 .foregroundStyle(.secondary)
	 .frame(height: 50)
	 .frame(maxWidth: .infinity, alignment: .leading)
	 .background(
		.white
	 )
	 .cornerRadius(25)
	 .background(
		Color.black,
		in: .rect(cornerRadius: 25).stroke(lineWidth: 1)
	 )
  }
}
