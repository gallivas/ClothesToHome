//
//  OwnerDetails.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/11/25.
//

import SwiftUI

struct OwnerDetails: View {
    var owner: Owner
    
    var body: some View {
        NavigationStack {
            List(owner.items) { item in
                Section("Items") {
                    
                }
            }
            .navigationTitle(Text("\(owner.firstName) \(owner.lastName)"))
        }
    }
}

#Preview {
    OwnerDetails(owner: Owner(firstName: "Stephen", lastName: "Gallivan", email: "sgallivan13@gmail.com"))
}
