//
//  Item.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/10/25.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable {
    var id: UUID
    var name: String
    var category: String
    var condition: String?
    var details: String?
    @Attribute(.externalStorage) var photo: Data?
    var brand: String?
    var location: Location
    var owner: Owner
    
    init(name: String, category: String, condition: String? = nil, details: String? = nil, photo: Data? = nil, brand: String? = nil, location: Location, owner: Owner) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.condition = condition
        self.details = details
        self.photo = photo
        self.brand = brand
        self.location = location
        self.owner = owner
    }
}
