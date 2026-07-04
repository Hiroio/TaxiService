//
//  MenuButton.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct MenuButton: View {
  @EnvironmentObject var navigation: NavigationManager
    var body: some View {
		Button{
		  if navigation.sheetState == .search{
			 navigation.sheetState = nil
		  }
		}label: {
		  Image(systemName: navigation.sheetState?.menuIcon ?? "line.3.horizontal")
			 .font(.headline.weight(.bold))
			 .foregroundStyle(.black)
			 .padding()
			 .background(
				.white,
				in: .circle
			 )
			 .compositingGroup()
			 .shadow(radius: 1)
		}
    }
}

#Preview {
  MenuButton()
	 .environmentObject(NavigationManager.shared)
}
