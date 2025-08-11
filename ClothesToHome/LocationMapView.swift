import SwiftUI
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// Accepts a list of type MapLocation (requiring name + coordinates) and returns a map centered on those coordinates.
struct LocationMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    private let locations: [MapLocation]
    
    init(locations: [MapLocation]) {
            self.locations = locations
        }
    
    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(locations) { location in
                Marker(location.name, coordinate: location.coordinate)
            }
        }
        .frame(height: 300)
        .onAppear {
            // Center the map on the first location
            if let first = locations.first {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: first.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                )
            }
        }
    }
}

#Preview {
    LocationMapView(locations: [
        MapLocation(
            name: "Statue of Liberty",
            coordinate: CLLocationCoordinate2D(latitude: 40.6892, longitude: -74.0445)
        )
    ])
}
