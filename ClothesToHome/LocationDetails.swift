//
//  LocationDetails.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/11/25.
//

import MapKit
import SwiftUI

struct LocationDetails: View {
    let location: Location
    @State private var hasValidCoordinates = false
    
    var body: some View {
        Form {
            Text(location.streetAddress)
            Text("\(location.city), \(location.state) \(location.postalCode)")
            Text(location.country)
            
            if hasValidCoordinates {
                Section(header: Text("Map")) {
                    LocationMapView(locations: [MapLocation(name: location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!))])
                }
            }
        }
        .navigationTitle(location.name)
        .onAppear {
            if location.latitude != nil && location.longitude != nil {
                hasValidCoordinates = true
            }
        }
    }
}

#Preview {
    LocationDetails(location: Location(name: "Home", streetAddress: "100 Main St", city: "Portland", state: "OR", postalCode: "12345", country: "USA"))
}
