//
//  ContentView.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/10/25.
//
//  Main screen lists all Owners
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Owner.lastName) var owners: [Owner]
    
    var body: some View {
        NavigationStack {
            List(owners) { owner in
                NavigationLink(destination: OwnerDetails(owner: owner)) {
                    HStack {
                        Text("\(owner.firstName) \(owner.lastName)")
                        Text(" \(owner.items.count) items in \(owner.locations.count) locations")
                    }
                }
            }
            .navigationTitle("All Owners")
            .toolbar {
                NavigationLink("Add Owner") {
                    AddOwner()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Owner.self)
}
