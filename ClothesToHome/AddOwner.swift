//
//  AddOwner.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/11/25.
//

import SwiftData
import SwiftUI

struct AddOwner: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section("Owner Information") {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .autocapitalization(.none)
            }
            Button("Save") {
                saveOwner()
            }
            .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty)
        }
    }
    
    func saveOwner() {
        let newOwner = Owner(firstName: firstName, lastName: lastName, email: email)
        modelContext.insert(newOwner)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save location: \(error.localizedDescription)")
        }
        dismiss()
    }
}

#Preview {
    AddOwner()
}
