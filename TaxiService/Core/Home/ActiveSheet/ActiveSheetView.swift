//
//  ActiveSheetView.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct ActiveSheetView: View {
  @EnvironmentObject var navigation: NavigationManager
  @State private var dragAmount: CGFloat = 0.0
  
  @State private var gestureState: Bool = false
  
  @StateObject private var locationSearchViewModel = LocationSearchViewModel()
    var body: some View {
		GeometryReader{ geo in
		  let baseHeight = locationSearchViewModel.panelState.height(geoHeight: geo.size.height)
		  VStack(){
			 RoundedRectangle(cornerRadius: 20)
				.frame(width: geo.size.width / (gestureState ? 4 : 5), height: 5)
				.gesture(
				  dragGesture(geoHeight: geo.size.height)
				)
			 
			 
			 switch navigation.sheetState {
			 case .search:
				LocationSearchView(panelState: locationSearchViewModel.panelState, viewModel: locationSearchViewModel)
			 case .payment:
				EmptyView()
			 case .driver:
				EmptyView()
			 default:
				EmptyView()
			 }
			 
			 
		  }
		  .padding()
		  .frame(height: baseHeight - dragAmount, alignment: .top)
		  .background(
			 UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, topTrailing: 20))
				.fill(.white)
				.shadow(radius: 5)
		  )
		  .frame(maxHeight: .infinity, alignment: .bottom)
		}
		.ignoresSafeArea(edges: .bottom)
		.animation(.easeInOut, value: locationSearchViewModel.panelState)
    }
}

#Preview {
    ActiveSheetView()
	 .environmentObject(NavigationManager.shared)
}



extension ActiveSheetView{
  func dragGesture(geoHeight: CGFloat) -> some Gesture{
		DragGesture()
		.onChanged { value in
		  withAnimation(){
			 gestureState = true
			 dragAmount = max(min(value.translation.height, 200), -200)
		  }
		}
		.onEnded { value in
		  gestureEnd(geoHeight: geoHeight)
		}
  }
  
  
  func gestureEnd(geoHeight: CGFloat) {
	 withAnimation(.easeInOut) {
		let currentHeight = locationSearchViewModel.panelState.height(geoHeight: geoHeight) - dragAmount
		let originalHeight = PanelState.original.height(geoHeight: geoHeight)
		let threshold: CGFloat = 100
		
		if currentHeight > originalHeight + threshold {
		  locationSearchViewModel.panelState = .expanded
		} else if currentHeight < originalHeight - threshold {
		  locationSearchViewModel.panelState = .collapsed
		} else {
		  locationSearchViewModel.panelState = .original
		}
		
		dragAmount = 0
		gestureState = false
	 }
  }
}
