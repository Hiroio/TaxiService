//
//  HomeView.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var navigation: NavigationManager
    var body: some View {
		ZStack{
		  MapViewRepresentable()
			 .ignoresSafeArea()
		  
		
		  VStack{
			 MenuButton()
				.frame(maxWidth: .infinity, alignment: .leading)
			 Spacer()
			 Spacer()
			 if navigation.sheetState == nil{
				Button{
				  withAnimation() {
					 navigation.sheetState = .search
				  }
				}label:{
				  LocationSearchActivationView()
				}
				.transition(.move(edge: .top).combined(with: .scale))
				
				.zIndex(1)
			 }
			 Spacer()
			 
		  }
		  .padding()
		  
		  if navigation.sheetState != nil{
			 ActiveSheetView()
				.transition(.move(edge: .bottom).combined(with: .opacity))
		  }
		}
		.animation(.linear, value: navigation.sheetState != nil)
    }
}

#Preview {
  HomeView().environmentObject(NavigationManager.shared)
}
