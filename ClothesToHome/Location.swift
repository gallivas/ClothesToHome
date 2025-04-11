//
//  Location.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/10/25.
//

import Foundation
import SwiftData

@Model
class Location: Identifiable {
    var id: UUID
    var name: String
    var streetAddress: String
    var apartmentNumber: String?
    var city: String
    var state: String
    var postalCode: String
    var country: String
    var owners: [Owner]?
    @Relationship(deleteRule: .cascade, inverse: \Item.location) var items: [Item]
    
    init(name: String, streetAddress: String, apartmentNumber: String? = nil, city: String, state: String, postalCode: String, country: String, owners: [Owner]? = nil) {
        self.id = UUID()
        self.name = name
        self.streetAddress = streetAddress
        self.apartmentNumber = apartmentNumber
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.country = country
        self.owners = owners
        self.items = []
    }
}
