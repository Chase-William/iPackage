//
//  SavedPackagesView.swift
//  iPackage
//
//  Created by xamarinapple on 4/19/22.
//

import SwiftUI
import CoreData

struct SavedPackagesView: View {
    @FetchRequest(sortDescriptors: []) var packages: FetchedResults<NugetPackage>
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationView {
            VStack {
                List(packages, id: \.self) { package in
                    PackageRow(package: package)
                }
                .refreshable {
                    for package in packages {
                        NugetWebService.syncWithRemote(package: package)
                    }
                }
            }
            .navigationTitle(Text("Bookmarked Packages"))
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
        .tabItem {
            Image(systemName: "bookmark")
        }
        .tag(Views.Saved)
    }
}

struct SavedPackagesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPackagesView()
    }
}
