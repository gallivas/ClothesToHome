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
    var owner: Owner
    @State private var isShowingAddItemSheet = false
    @State private var isShowingAddLocationSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Items") {
                    ForEach(owner.items) { item in
                        Text("\(item.name)")
                    }
                }
                
                Section("Locations") {
                    ForEach(owner.locations) { location in
                        NavigationLink(destination: LocationDetails(location: location)) {
                            Text("\(location.name)")
                        }
                    }
                }
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
