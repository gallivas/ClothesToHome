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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State private var hasValidCoordinates = false
    
    var body: some View {
        Form {
            Text(location.streetAddress)
            Text("\(location.city), \(location.state) \(location.postalCode)")
            Text(location.country)
            
            if hasValidCoordinates {
                Section(header: Text("Map")) {
                    Map(coordinateRegion: $region,
                        annotationItems: [MapPin(latitude: location.latitude!, longitude: location.longitude!)]) { pin in
                        MapAnnotation(coordinate: pin.coordinate) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .frame(height: 300)
                }
            }
        }
        .navigationTitle(location.name)
        .onAppear {
            if let lat = location.latitude, let lon = location.longitude {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                                            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                hasValidCoordinates = true
            }
        }
    }
}

struct MapPin: Identifiable {
    let id: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.id = "\(latitude),\(longitude)"
    }
}

#Preview {
    LocationDetails(location: Location(name: "Home", streetAddress: "100 Main St", city: "Portland", state: "OR", postalCode: "12345", country: "USA"))
}
