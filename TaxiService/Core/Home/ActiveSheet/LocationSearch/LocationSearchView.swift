//
//  LocationSearchView.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct LocationSearchView: View {
  let panelState: PanelState
  @ObservedObject var viewModel: LocationSearchViewModel
  @State private var userLocation: String = ""
  var body: some View {
		VStack(){
			  VStack(alignment: .leading, spacing: 0){
				 HStack{
				Image(systemName: "car.side.fill")
				  .scaleEffect(x: -1)
				
				TextField("User Location", text: $userLocation, prompt: Text("Where you at"))
				  .padding()
				  .background(
					 RoundedRectangle(cornerRadius: 25)
						.stroke(.secondary, lineWidth: 1)
				  )
			 }
			 
			 Rectangle()
				.frame(width: 1, height: 25)
				.padding(.leading, 9)
			 HStack{
				Image(systemName: "flag.checkered")
				
				TextField("User Location", text: $viewModel.queryFragment, prompt: Text("Where we heading"))
				  .padding()
				  .background(
					 RoundedRectangle(cornerRadius: 25)
						.stroke(.secondary, lineWidth: 1)
				  )
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
			.padding()
	  }
}

#Preview {
  LocationSearchView(panelState: .original, viewModel: .init())
}
