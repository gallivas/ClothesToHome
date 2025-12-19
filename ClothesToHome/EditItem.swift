//
//  EditItem.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 12/12/25.
//
import PhotosUI
import SwiftUI

struct EditItem: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var item: Item
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var isShowingAddLocationSheet = false
    
    var body: some View {
        Form {
            Section("Item Name") {
                TextField("*Item Name", text: $item.name)
            }
            Section("Photo") {
                HStack {
                    Spacer()
                    PhotoPickerView(selectedItem: $selectedItem, itemImage: $item.photo)
                    Spacer()
                }
            }
            
            Section(header: Text("Item Details")) {
                TextField("*Category", text: $item.category)
                TextField("Condition (Optional)",
                          text: Binding(
                            get: { item.condition ?? "" },
                            set: { item.condition = $0.isEmpty ? nil : $0 }
                          )
                )
                
                TextField("Details (Optional)",
                          text: Binding(
                            get: { item.details ?? "" },
                            set: { item.details = $0.isEmpty ? nil : $0 }
                          )
                )
                TextField("Brand (Optional)",
                          text: Binding(
                            get: { item.brand ?? "" },
                            set: {item.brand = $0.isEmpty ? nil : $0 }
                          )
                )
            }
            
            Section(header: Text("Location")) {
                    Button("Create New Location") {
                        isShowingAddLocationSheet.toggle()
                    }
                    Picker("", selection: $item.location) {
                        ForEach(item.owner.locations, id: \.self) { loc in
                            Text(loc.name).tag(loc as Location?)
                        }
                    }
                }
            }
        .sheet(isPresented: $isShowingAddLocationSheet) {
            AddLocation(owner: item.owner)
        }
            
            Button("Save Item") {
                dismiss()
            }
            .disabled(item.name.isEmpty || item.category.isEmpty)
    }
}

#Preview {
    let owner = Owner(firstName: "Stephen", lastName: "Gallivan", email: "test@email.com")
    let location1 = Location(name: "Home", streetAddress: "1 Test Drive", city: "Portland", state: "OR", postalCode: "12345", country: "USA")
    let location2 = Location(name: "Beach House", streetAddress: "40 Beach Blvd", city: "Los Angeles", state: "CA", postalCode: "54321", country: "USA")
    
    owner.locations = [location1, location2]
    
    return EditItem(item: Item(name: "Test Item", category: "This is a test item", condition: "Used", details: "None", brand: "Nike", location: location1, owner: owner))
}
