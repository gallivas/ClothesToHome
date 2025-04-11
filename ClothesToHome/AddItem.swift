//
//  AddItem.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/11/25.
//
//  Add Item to associated Owner
//

import SwiftUI

struct AddItem: View {
    @Environment(\.modelContext) var modelContext
    var owner: Owner
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AddItem(owner: Owner(firstName: "Stephen", lastName: "Gallivan", email: "test@email.com"))
}
