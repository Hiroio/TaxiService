//
//  MenuButton.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct MenuButton: View {
    var body: some View {
		Button{
		}label: {
		  Image(systemName: "line.3.horizontal")
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
}
