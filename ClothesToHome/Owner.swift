//
//  Owner.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/10/25.
//

import Foundation
import SwiftData

@Model
class Owner: Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
//    Owned Item object should be destroyed when Owner removes item from its collection since an Item can have only one owner
    @Relationship(deleteRule: .cascade, inverse: \Item.owner) var items: [Item]
//    Owned Location object should be nullified for self.Owner rather than deleted, because other Owners may reference the Location
    @Relationship(deleteRule: .nullify, inverse: \Location.owners) var locations: [Location]
    
    init(firstName: String, lastName: String, email: String) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.items = []
        self.locations = []
    }
}
