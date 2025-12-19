//
//  ItemDetails.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 9/18/25.
//

import MapKit
import SwiftUI

struct ItemDetails: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    let item: Item
    var attributes: [(label: String, value: String)] {
        [
            ("Name", item.name),
            ("Category", item.category),
            ("Condition", item.condition ?? "–"),
            ("Details", item.details ?? "–"),
            ("Brand", item.brand ?? "–"),
            ("Owner", item.owner.firstName)
        ]
    }
    
    @State private var showEdit = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    PhotoView(photoData: item.photo)
                        .frame(height: 300)
                    Spacer()
                }
                    
            }
            Section {
                ForEach(attributes, id: \.label) { attribute in
                    HStack {
                        Text(attribute.label + ":")
                            .bold()
                            .frame(width: 100, alignment: .leading)
                        Text(attribute.value)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                }
            }
            Section {
                LocationMapView(locations: [MapLocation(name: item.location.name, coordinate: CLLocationCoordinate2D(latitude: item.location.latitude ?? 0, longitude: item.location.longitude ?? 0))])
                    .frame(height: 150)
            }
        }
        .navigationTitle("Item Details")
        .toolbar {
            Menu("Actions") {
                Button("Edit") {
                    showEdit = true
                }
                Button("Delete") {
                    modelContext.delete(item)
                    do {
                        try modelContext.save()
                    } catch {
                        print("Failed to delete item: \(error.localizedDescription)")
                    }
                    dismiss()
                }
                
            }
            .navigationDestination(isPresented: $showEdit) {
                EditItem(item: item)
            }
        }
    }
}

#Preview {
    ItemDetails(item: Item(name: "Shearling Lined Bean Boots", category: "Footwear", condition: "New", details: "Size 11 Limited Edition 8\" Bean Boots", brand: "L.L.Bean", location: Location(name: "TestLocation", streetAddress: "1 Apple Park Way", city: "Cupertino", state: "CA", postalCode: "95014", country: "USA"), owner: Owner(firstName: "Stephen", lastName: "Gallivan", email: "test@test.com")))
}
