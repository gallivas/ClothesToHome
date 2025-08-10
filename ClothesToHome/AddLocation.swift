//
//  AddLocation.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/15/25.
//

import CoreLocation
import SwiftUI

struct AddLocation: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var owner: Owner
    
    @State private var name = ""
    @State private var streetAddress = ""
    @State private var apartmentNumber = ""
    @State private var city = ""
    @State private var state = ""
    @State private var postalCode = ""
    @State private var country = ""
    
    var body: some View {
        Form {
            Section("Location Name") {
                TextField("*Location Name", text: $name)
            }
            Section(header: Text("Address Details")) {
                TextField("*Street Address", text: $streetAddress)
                TextField("Apartment/Unit (Optional)", text: $apartmentNumber)
                HStack {
                    TextField("*City", text: $city)
                    TextField("*State", text: $state)
                }
                HStack {
                    TextField("*Postal Code", text: $postalCode).keyboardType(.numberPad)
                    TextField("*Country", text: $country)
                }
            }
            
            Button("Save Location") {
                saveLocation()
            }
            .disabled(name.isEmpty || streetAddress.isEmpty || city.isEmpty || state.isEmpty || postalCode.isEmpty || country.isEmpty)
        }
    }
    
    func saveLocation() {
        let newLocation = Location(name: name, streetAddress: streetAddress, apartmentNumber: apartmentNumber, city: city, state: state, postalCode: postalCode, country: country)
        owner.locations.append(newLocation)
        modelContext.insert(newLocation)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save location: \(error.localizedDescription)")
        }
        let fullAddress = "\(streetAddress), \(city), \(state) \(postalCode), \(country)"
        
        getCoordinate(addressString: fullAddress) { coordinate, error in
            if CLLocationCoordinate2DIsValid(coordinate) {
                newLocation.latitude = coordinate.latitude
                newLocation.longitude = coordinate.longitude
                try? modelContext.save()
            }
        }
        
        dismiss()
    }
}

#Preview {
    AddLocation(owner: Owner(firstName: "Stephen", lastName: "Gallivan", email: "test@email.com"))
}
