//
//  HomeView.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct HomeView: View {
  @State private var searchActive: Bool = false
    var body: some View {
		ZStack{
		  MapViewRepresentable()
			 .ignoresSafeArea()
		  
		
		  VStack{
			 MenuButton()
				.frame(maxWidth: .infinity, alignment: .leading)
			 Spacer()
			 Spacer()
			 if !searchActive{
				Button{
				  withAnimation() {
					 searchActive.toggle()
				  }
				}label:{
				  LocationSearchActivationView()
				}
				.transition(.asymmetric(insertion: .opacity, removal: .scale))
				
				.zIndex(1)
			 }
			 Spacer()
			 
		  }
		  .padding()
		}
		
		.sheet(isPresented: $searchActive) {
		  LocationSearchView()
			 .presentationDetents([.medium, .large])
			 .presentationBackground(.white)
		}
		.animation(.linear, value: searchActive)
    }
}

#Preview {
    HomeView()
}
