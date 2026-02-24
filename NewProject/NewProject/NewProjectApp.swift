//
//  NewProjectApp.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 11/02/26.
//

import SwiftUI

@main
struct NewProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PhotoViewScreen()
            //ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
