//
//  AddItem.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/11/25.
//
//  Add Item to associated Owner
//

import PhotosUI
import SwiftUI

struct AddItem: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var owner: Owner
    
    @State private var name = ""
    @State private var category = ""
    @State private var condition = ""
    @State private var details = ""
    @State private var brand = ""
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var itemImage: Data?
    
    var locations: [Location] {
        owner.locations
    }
    @State private var location: Location?
    
    @State private var isShowingAddLocationSheet = false
    
    init(owner: Owner) {
        self.owner = owner
        _location = State(initialValue: owner.locations.first)
    }
    
    var body: some View {
        Form {
            Section("Item Name") {
                TextField("*Item Name", text: $name)
            }
            Section("Photo") {
                HStack {
                    Spacer()
                    PhotoPickerView(selectedItem: $selectedItem, itemImage: $itemImage)
                    Spacer()
                }
            }
            
            Section(header: Text("Item Details")) {
                TextField("*Category", text: $category)
                TextField("Condition (Optional)", text: $condition)
                TextField("*Details", text: $details)
                TextField("*Brand", text: $brand)
            }
            
            Section(header: Text("Location")) {
                if locations.isEmpty {
                    Button("Create New Location") {
                        isShowingAddLocationSheet.toggle()
                    }
                } else {
                    Picker("", selection: $location) {
                        ForEach(locations, id: \.self) { loc in
                            Text(loc.name).tag(loc as Location?)
                        }
                    }
                }
            }
            
            Button("Save Item") {
                saveItem()
            }
            .disabled(name.isEmpty || category.isEmpty || details.isEmpty || brand.isEmpty || location == nil)
        }
        .sheet(isPresented: $isShowingAddLocationSheet) {
            AddLocation(owner: owner)
        }
    }
    
    func saveItem() {
        let newItem = Item(name: name, category: category, condition: condition, details: details, photo: itemImage, brand: brand, location: location!, owner: owner)
        owner.items.append(newItem)
        modelContext.insert(newItem)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save location: \(error.localizedDescription)")
        }
        dismiss()
    }
}

#Preview {
    let owner = Owner(firstName: "Stephen", lastName: "Gallivan", email: "test@email.com")
    let location1 = Location(name: "Home", streetAddress: "1 Test Drive", city: "Portland", state: "OR", postalCode: "12345", country: "USA")
    let location2 = Location(name: "Beach House", streetAddress: "40 Beach Blvd", city: "Los Angeles", state: "CA", postalCode: "54321", country: "USA")
    
    owner.locations = [location1, location2]
    
    return AddItem(owner: owner)
}
