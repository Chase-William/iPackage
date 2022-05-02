//
//  iPackageApp.swift
//  iPackage
//
//  Created by xamarinapple on 4/10/22.
//

import SwiftUI

@main
struct iPackageApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var settings = Settings()
    
    @Environment(\.scenePhase) var scenePhase // Notifies when app moves to background
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settings)
        }
    }
}
