//
//  SearchTextField.swift
//  TaxiService
//
//  Created by user on 05.07.2026.
//

import SwiftUI

struct SearchTextField: View {
  @EnvironmentObject var viewModel: LocationSearchViewModel
  let nameSpace: Namespace.ID
  let searchState: SearchState
    var body: some View {
		VStack{
		  HStack(spacing: 0){
			 Image(systemName: searchState.icon)
				.padding(.leading, 10)
			 
			 Rectangle()
				.frame(width: 2)
				.padding(.leading, 5)
			 
			 HStack{
				TextField("", text: $viewModel.queryFragment, prompt: Text(searchState.textfieldText))
				  .padding(.leading, 10)
				  .frame(height: 55)
				  .background(
					 UnevenRoundedRectangle(cornerRadii: .init(topLeading: 10, bottomLeading: 10, bottomTrailing: 25, topTrailing: 25))
						.fill(.black.opacity(0.05))
				  )
				
				Button{
				  withAnimation(){
					 viewModel.queryFragment = ""
				  }
				}label:{
				  Image(systemName: "xmark.circle.fill")
					 .padding(.trailing)
				}
				.disabled(viewModel.queryFragment.isEmpty)
			 }
			 .disabled(viewModel.locationSearchState == .map)
		  }
		  .foregroundStyle(.secondary)
		  .frame(height: 50)
		  .frame(maxWidth: .infinity, alignment: .leading)
		  .background(
			 RoundedRectangle(cornerRadius: 25)
				.fill(.white)
				.shadow(radius: 2, y: 5)
		  )
		  .background(
			 Color.black,
			 in: .rect(cornerRadius: 25).stroke(lineWidth: 2)
		  )
		  .compositingGroup()
		  .matchedGeometryEffect(id: searchState.geometryId, in: nameSpace)
		  
		  if viewModel.locationSearchState == .text{
			 Button{
				withAnimation(){
				  viewModel.locationSearchState = .map
				}
			 }label:{
				HStack{
				  Image(systemName: "map.fill")
					 .foregroundStyle(.green)
				  Text("Use map for location")
					 .foregroundStyle(.black)
				}
				.font(.headline)
				.padding(8)
			 }
			 .transition(.move(edge: .top).combined(with: .opacity))
			 .allowsHitTesting(viewModel.locationSearchState == .text)
		  }
		}
		.background(
		  Color.black,
		  in: .rect(cornerRadius: 25).stroke(lineWidth: 1)
		)
    }
}

#Preview {
  @Previewable @Namespace var nameSpace
  SearchTextField(nameSpace: nameSpace, searchState: .destination)
	 .environmentObject(LocationSearchViewModel())
}
