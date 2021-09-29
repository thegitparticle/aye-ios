//
//  toastgo_goApp.swift
//  toastgo-go
//
//  Created by SAN on 9/29/21.
//

import SwiftUI

@main
struct toastgo_goApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
