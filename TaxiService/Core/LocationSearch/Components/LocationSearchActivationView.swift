//
//  LocationSearchActivationView.swift
//  TaxiService
//
//  Created by user on 04.07.2026.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
		HStack(){
		  Image(systemName: "car.side.fill")
		  
		  Rectangle()
			 .frame(width: 1)
			 .padding(.horizontal)
		  Text("Where we going?")
			 .font(.headline.weight(.medium))
		}
		.foregroundStyle(.secondary)
		.frame(height: 50)
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
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

#Preview {
    LocationSearchActivationView()
}
