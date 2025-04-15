//
//  LocationDetails.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/11/25.
//

import SwiftUI

struct LocationDetails: View {
    let location: Location
    var body: some View {
        Form {
            Text(location.streetAddress)
            Text("\(location.city), \(location.state) \(location.postalCode)")
            Text(location.country)
        }
        .navigationTitle(location.name)
    }
}

#Preview {
    LocationDetails(location: Location(name: "Home", streetAddress: "100 Main St", city: "Portland", state: "OR", postalCode: "12345", country: "USA"))
}
