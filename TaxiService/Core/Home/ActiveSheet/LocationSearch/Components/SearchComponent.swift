//
//  SearchComponent.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct SearchComponent: View {
  let title: String
  let subTitle: String
    var body: some View {
		HStack(alignment: .bottom, spacing: 15){
		  Image(systemName: "pin.fill")
			 .font(.headline)
			 .foregroundStyle(.cyan)
			 .padding(15)
			 .background(
				Circle()
				  .fill(.white)
				  .shadow(radius: 4)
			 )
		  
		  VStack(alignment: .leading){
			 Text(title)
				.font(.headline)
			 Text(subTitle)
				.font(.caption)
				.foregroundStyle(.secondary)
			 Divider()
		  }
		}
		.frame(height: 55)
    }
}

#Preview {
  SearchComponent(title: "", subTitle: "")
}
