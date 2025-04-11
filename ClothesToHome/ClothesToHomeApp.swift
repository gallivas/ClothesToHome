//
//  ClothesToHomeApp.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 4/10/25.
//

import SwiftData
import SwiftUI

@main
struct ClothesToHomeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Owner.self)
    }
}
