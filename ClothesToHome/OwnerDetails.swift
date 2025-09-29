//
//  OwnerDetails.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/11/25.
//
//
//  Shows the items and Locations associated with the previously selected Owner.

import SwiftUI

struct OwnerDetails: View {
    @Environment(\.modelContext) var modelContext
    var owner: Owner
    @State private var isShowingAddItemSheet = false
    @State private var isShowingAddLocationSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Items") {
                    ForEach(owner.items) { item in
                        NavigationLink(destination: ItemDetails(item: item)) {
                            Text("\(item.name)")
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let item = owner.items[index]
                            modelContext.delete(item)
                        }
                        try? modelContext.save()
                    }
                }
                // TODO: Delete item (swipe gesture)
                
                Section("Locations") {
                    ForEach(owner.locations) { location in
                        NavigationLink(destination: LocationDetails(location: location)) {
                            Text("\(location.name)")
                        }
                    }
                }
                // TODO: Delete location (swipe gesture, cascade deletes items stored at this location)
            }
            .navigationTitle(Text("\(owner.firstName) \(owner.lastName)"))
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button("New Item") {
                            isShowingAddItemSheet.toggle()
                        }
                        
                        Button("New Location") {
                            isShowingAddLocationSheet.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            }
        }
        .sheet(isPresented: $isShowingAddItemSheet) {
            AddItem(owner: owner)
        }
        .sheet(isPresented: $isShowingAddLocationSheet) {
            AddLocation(owner: owner)
        }
    }
}

#Preview {
    OwnerDetails(owner: Owner(firstName: "Stephen", lastName: "Gallivan", email: "test@email.com"))
}
