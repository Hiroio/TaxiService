//
//  HomeView.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct HomeView: View {
  @Namespace var homeNameSpace
  @EnvironmentObject var navigation: NavigationManager
    var body: some View {
		ZStack{
		  MapViewRepresentable()
			 .ignoresSafeArea()
		  
		
		  VStack{
			 MenuButton()
				.frame(maxWidth: .infinity, alignment: .leading)
			 Spacer()
			 if navigation.sheetState == nil{
				Button{
				  withAnimation() {
					 navigation.sheetState = .search
				  }
				}label:{
				  LocationSearchActivationView()
				}
				.zIndex(1)
				.matchedGeometryEffect(id: SearchState.destination.geometryId, in: homeNameSpace)
			 }
			 
		  }
		  .padding()
		  
		  if navigation.sheetState != nil{
			 ActiveSheetView(nameSpace: homeNameSpace)
				.transition(.move(edge: .bottom).combined(with: .opacity))
		  }
		}
		.animation(.linear, value: navigation.sheetState != nil)
    }
}

#Preview {
  HomeView()
	 .environmentObject(NavigationManager.shared)
	 .environmentObject(LocationSearchViewModel())
}
